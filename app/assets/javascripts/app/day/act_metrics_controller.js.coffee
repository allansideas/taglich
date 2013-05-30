angular.module('states.day')
.controller("ActMetricsCtrl", ["$scope", "$state", "MetricScore", "DateUtilsService", ($scope, $state, MetricScore, DateUtilsService) ->
  console.log "--ActMetricsCtrl--"
  $scope.metric_scores = MetricScore.query(year: "2013", month:"05", day:"23")

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
