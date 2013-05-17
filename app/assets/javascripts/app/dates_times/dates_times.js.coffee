angular.module('dates_times', ['resources.dates_times'])


.config(['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
  #move to filter
  normalizeDate = (date)->
    date.replace(/\b(\d{1})\b/g, '0$1')

  getJSDateFromURLString = (date_string)->
    #Y/M/D -> [0] = Y, [1] = M, [2] = D
    dateArry = date_string.split("/").splice(1,3)
    jsDate = new Date(dateArry[0], dateArry[1] - 1, dateArry[2])
    jsDate

  formatDateURL = (date)->
    "/" + date.getFullYear() + "/" + normalizeDate((1 + date.getMonth()).toString()) + "/" + normalizeDate(date.getDate().toString()) 

  #match server time
  date = new Date()
  $urlRouterProvider.otherwise("/" + date.getFullYear() + "/" + normalizeDate((1 + date.getMonth()).toString()) + "/" + normalizeDate(date.getDate().toString()) )

  $stateProvider.state('day', 
    url: '/:year/:month/:day'
    views:
      '':
        templateUrl: 'templates/dates_times/day.html'
        controller: ["$scope", "$stateParams", "$state", "$location", "Day", "DayByDate", ($scope, $stateParams, $state, $location, Day, DayByDate) ->
          $scope.day = DayByDate.get({year: $stateParams.year, month: $stateParams.month, day: $stateParams.day})
          $scope.currentDayURL = "/"+$stateParams.year+"/"+$stateParams.month+"/"+$stateParams.day
          $scope.prevDayURL = ()->
            date_string = $scope.currentDayURL
            date = getJSDateFromURLString(date_string)
            prev_day = new Date(date.setDate(date.getDate() - 1))
            prev_day = formatDateURL(prev_day)
            prev_day
          $scope.nextDayURL = ()->
            date_string = $scope.currentDayURL
            date = getJSDateFromURLString(date_string)
            next_day = new Date(date.setDate(date.getDate() + 1))
            next_day = formatDateURL(next_day)
            next_day

          $scope.isEditMode = false
          $scope.show_graphs = ()->
            $state.transitionTo('day.graphs', $stateParams)
        ]
      'metrics@day':
        templateUrl: 'templates/metrics/metrics.html'
        controller: ["$scope", "$stateParams", "$state", "MetricScore", "UserMetric", "MetricSorter", ($scope, $stateParams, $state, MetricScore, UserMetric, MetricSorter) ->
          $scope.isAdding = false
          #to be added metric
          $scope.metric = {}
          $scope.metric.score_type = "small_number"

          $scope.addMetric = (metric)->
            $scope.isProcessing = true
            $scope.metric.state = 'active'
            UserMetric.save({uid: $scope.day.user.id}, metric, (data)->
              MetricScore.save(metric_id: data.id, day_id: $scope.day.id, (data)->
                $scope.day.metric_scores.unshift(data)
                $scope.isAdding = false
                $scope.isProcessing = false
                $scope.metric.name = ''
              )
            )

          $scope.changeMetricState = (state, ms, $index)->
            $scope.day.metric_scores.splice($index, 1)
            UserMetric.update({uid: $scope.day.user.id, id: ms.metric.id}, {metric: {state: state}}, (data)->
              MetricScore.delete(id: ms.id)
            )

          $scope.updateMetricScore = (ms)->
            switch ms.metric.score_type
              when "small_number","big_number"
                MetricScore.update({id: ms.id, score: ms.score})
              when "boolean"
                ms.score = if ms.score == 0 then ms.score = 1 else ms.score = 0
                MetricScore.update({id: ms.id, score: ms.score})

          $scope.sort = (params)->
            MetricSorter.sort(metrics: params)

          #$scope.$watch "day.metric_scores", ((new_val, old_val) ->
          #), true

          $scope.$watch('day.metric_scores', (newval, oldval)->
                       console.log newval
                       console.log oldval
                       if newval? and oldval?
                         if newval.length == oldval.length
                          if (newval != oldval)
                            for ms, index in newval
                              if ms.score != oldval[index].score
                                MetricScore.update({id: ms.id, score: ms.score})
          , true)
        ]
      'flash_cards@day':
        templateUrl: 'templates/flash_cards/flash_cards.html'
  ).state('day.graphs',
    url: '/graphs'
    views:
      'metrics@day':
        templateUrl: 'templates/metrics/metrics_graphs.html'
        controller: ["$scope", "$stateParams", "$state", "$http", "Day", "DayByDate", ($scope, $stateParams, $state, $http,  Day, DayByDate ) ->
          $scope.show_metrics = ()->
            $state.transitionTo('day', $stateParams)

          $scope.$watch("day.metric_scores", (value)->
              val = value || null;            
              if (val)
                for v, index in val
                  if (v.last_8.length)
                    chart = 'chart_'+ index
                    console.log chart
                    $scope.flotr('chart_'+index, v)
          )
          $scope.flotr = (container_id, ms)->
            $http(
              method: "GET"
              url: "/metric_scores/"+ms.id+"/graph_data"
            ).success((data, status, headers, config) ->
              container = document.getElementById(container_id)
              d1 = data

              options =
                xaxis:
                  mode: 'time'
                  timeUnit: 'second'
                  labelsAngle: 45
                selection:
                  mode: 'x'
                HtmlText: false
                title: ms.metric.name
              
              drawGraph = (opts)->
                o = Flotr._.extend(Flotr._.clone(options), opts or {})
                Flotr.draw container, [d1], o

              graph = drawGraph()

              Flotr.EventAdapter.observe container, "flotr:select", (area) ->
                graph = drawGraph(
                  xaxis:
                    min: area.x1
                    max: area.x2
                    mode: "time"
                    labelsAngle: 45

                  yaxis:
                    min: area.y1
                    max: area.y2
                )

              Flotr.EventAdapter.observe container, "flotr:click", ->
                graph = drawGraph()
            )
          
          #$scope.flotr(document.getElementById('chart'), $scope.$parent.day.metric_scores[0])
        ]   
      'flash_cards':
        template: ''
  )

])

#.controller("DayCtrl", ["$scope", "$filter", "$stateParams", "Day", "DayByDate", ($scope, $filter, $stateParams, Day, DayByDate) ->
  #$scope.day = DayByDate.get({year: $stateParams.year, month: $stateParams.month, day: $stateParams.day})

  #$scope.currentDay = ()->
    #today = $filter('date')(new Date(), "yyyy-MM-dd")
    #true if today == $scope.day.date
#])
