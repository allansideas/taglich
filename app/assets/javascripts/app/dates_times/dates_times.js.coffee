angular.module('dates_times', ['resources.dates_times'])


.config(['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
  
  #move to filter
  normalizeDate = (date)->
    date.replace(/\b(\d{1})\b/g, '0$1')

  getRandomInt = (min, max)->
    return Math.floor(Math.random() * (max - min + 1)) + min



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
        controller: ["$scope", "$stateParams", "$state", "$location", "$http", "Day", "DayByDate", ($scope, $stateParams, $state, $location, $http, Day, DayByDate) ->
          $scope.day = DayByDate.get({year: $stateParams.year, month: $stateParams.month, day: $stateParams.day}, (day_data)->
            $http(
              method: "GET"
              url: "/fetch_german_remember"
            ).success((data, status, headers, config) ->
              day_data.cards = data
              day_data.rand = getRandomInt(0, day_data.cards.length - 1)
              day_data.card = day_data.cards[day_data.rand]
            )
          )
          console.log $scope.day
          $scope.currentDayURL = "/"+$stateParams.year+"/"+$stateParams.month+"/"+$stateParams.day
          $scope.todayURL = ()->
            today = new Date()
            today = formatDateURL(today)
            today
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
          $scope.show_metrics = ()->
            $state.transitionTo('day.metrics', $stateParams)
        ]
      'metrics@day':
        templateUrl: 'templates/metrics/metrics.html'
        controller: ["$scope", "$stateParams", "$state", "uiDebounce", "MetricScore", "UserMetric", "MetricSorter", ($scope, $stateParams, $state, uiDebounce, MetricScore, UserMetric, MetricSorter) ->
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
          #equivalent to delete (inactive/active).
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

          $scope.getMetricRowClass = (ms)->
            if ms.last_8.length > 0?
              if (ms.score > ms.last_8[ms.last_8.length - 1].score) || (ms.metric.score_type == "boolean" && ms.score == 1)
                return "green-row"
              if ms.score > 0 && ms.score < ms.last_8[ms.last_8.length - 1].score && ms.metric.score_type != "boolean"
                return "orange-row"
              else
                return "gray-row"
            else
              return "gray-row"


          $scope.updateAfterWatch = (ms)->
             if ms.score == null
               return
             MetricScore.update({id: ms.id, score: ms.score}, (data)->
               metric = data.metric.sort_order - 1
               $scope.day.metric_scores[metric].streak = data.streak
             )

          $scope.debouncedUpdateMS = uiDebounce($scope.updateAfterWatch, 300, false)

          $scope.$watch('day.metric_scores', (newval, oldval)->
            if newval? and oldval?
              if newval.length == oldval.length
               if (newval != oldval)
                 for ms, index in newval
                   if ms.score != oldval[index].score
                     $scope.debouncedUpdateMS(ms)
          , true)
        ]
      'flash_cards@day':
        templateUrl: 'templates/flash_cards/flash_cards.html'
        controller: ["$scope", "$stateParams", "$state", "$http", ($scope, $stateParams, $state, $http) ->
          getRandomInt = (min, max)->
            return Math.floor(Math.random() * (max - min + 1)) + min

          $scope.showing_side = 1
          $scope.flip = ()->
            sides = [1,2]
            $scope.showing_side = sides[sides.length - $scope.showing_side]
          $scope.got_it = ()->
            $scope.day.cards.splice($scope.day.rand, 1)
            if $scope.day.cards.length == 0
              $scope.day.card = {}
              $scope.day.card.side_1 = "Done" 
              $scope.day.card.side_2 = "Done" 
              return $scope.day.card
            $scope.day.rand = getRandomInt(0, $scope.day.cards.length - 1)
            $scope.day.card = $scope.day.cards[$scope.day.rand]
          $scope.muffed_it = ()->
            $scope.day.rand = getRandomInt(0, $scope.day.cards.length - 1)
            $scope.day.card = $scope.day.cards[$scope.day.rand]

        ]
  ).state('day.graphs',
    url: '/graphs'
    views:
      'metrics@day':
        templateUrl: 'templates/metrics/metrics_graphs.html'
        controller: ["$scope", "$stateParams", "$state", "$http", "Day", "DayByDate", ($scope, $stateParams, $state, $http,  Day, DayByDate ) ->
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
