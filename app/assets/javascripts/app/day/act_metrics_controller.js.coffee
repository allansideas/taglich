angular.module('states.day.metrics_controller', [])
.controller("ActMetricsCtrl", ["$http", "$scope", "$state", "MetricScoreIDs", ($http, $scope, $state, MetricScoreIDs) ->
  console.log "--ActMetricsCtrl--"
  $scope.$parent.$watch('active_day', (new_val, old_val)->
    if new_val != old_val
      $http(
        method: "GET"
        url: "/days/"+$scope.$parent.active_day.id+"/metric_scores/only_ids"
      ).success((data, status, headers, config) ->
        $scope.metric_score_ids = data
        #metric_score_ids = []
        #for i in data
          #metric_score_ids.push(i)
        console.log $scope.metric_score_ids
      )

      #$scope.metric_scores = MetricScore.query(day_id: $scope.$parent.active_day.id)
  )
])

#.controller("MetricScoreItemCtrl", ["$scope", "MetricScore", ($scope, MetricScore) ->
  ##$scope.metric_scores = MetricScore.query()

  ##$scope.updateMetricScore = (ms)->
    ##MetricScore.update({id: ms.id, score: ms.score})

  ##$scope.prevScore = (ms, prev_mss)->
    ##score = 0
    ##if prev_mss?
      ##for sc in prev_mss
        ##score = sc.score if ms.metric.id == sc.metric.id
    ##score
#])

#.controller("MetricScoreCtrl", ["$scope", "MetricScore", ($scope, MetricScore) ->
  ##$scope.metric_scores = MetricScore.query()
#])
