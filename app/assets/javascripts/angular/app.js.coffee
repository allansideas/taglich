app = angular.module("Taglich", ["ngResource"])

app.config(["$httpProvider", (provider)-> 
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

app.factory "Day", ["$resource", ($resource) ->
  $resource("/days/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Week", ["$http", ($http) ->
  $http.get('days/week').then((response)->
    response.data
  )
]

app.factory "MetricScore", ["$resource", ($resource) ->
  $resource("/metric_scores/:id/", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Yesterday", ["$http", ($http) ->
  return {
      get: ()->
        $http.get('days/yesterday').success( (data)->
          data
        )
  }
]


app.directive "ngFocus", ["$parse", ($parse) ->
  (scope, element, attr) ->
    fn = $parse(attr["ngFocus"])
    element.bind "focus", (event) ->
      scope.$apply ->
        fn scope,
          $event: event
]

app.directive "ngBlur", ["$parse", ($parse) ->
  (scope, element, attr) ->
    fn = $parse(attr["ngBlur"])
    element.bind "blur", (event) ->
      scope.$apply ->
        fn scope,
          $event: event
]

@WeekCtrl = ["$scope", "Week", "$filter", ($scope, Week, $filter) ->
  $scope.week_days = Week
  #$scope.findDay = (date)->
    #array = []
    #console.log $scope.week_days.then((response)-> response.data) 
    #for key in $scope.week_days.then((response)-> response.data) 
      #console.log key
      #array.push($scope.week_days[key])

    ##day = $filter('filter')(@week_days, ()->
      ##console.log date
      ##true if Date.parse($scope.day.date) == (new Date().getDate() - 1)
    ##)
    ##return day
]

@DayCtrl = ["$scope", "$filter", "Day", ($scope, $filter, Day) ->
  $scope.currentDay = ()->
    today = $filter('date')(new Date(), "yyyy-MM-dd")
    true if today == $scope.day.date
]

@MetricScoreItemCtrl = ["$scope", "MetricScore", "Yesterday", ($scope, MetricScore, Yesterday) ->
  $scope.metric_scores = MetricScore.query()
  $scope.yesterday = Yesterday.get()

  $scope.updateMetricScore = (ms)->
    MetricScore.update({id: ms.id, score: ms.score})

  $scope.prevScore = (ms, prev_mss)->
    console.log prev_mss
    score = 0
    if prev_mss?
      for sc in prev_mss
        score = sc.score if ms.metric.id == sc.metric.id
    score
]

@MetricScoreCtrl = ["$scope", "MetricScore", ($scope, MetricScore) ->
  $scope.metric_scores = MetricScore.query()
]

