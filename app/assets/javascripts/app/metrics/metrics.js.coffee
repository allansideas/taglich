angular.module('metrics', ['resources.metrics'])

.controller("MetricScoreItemCtrl", ["$scope", "MetricScore", ($scope, MetricScore) ->
  $scope.metric_scores = MetricScore.query()

  #$scope.updateMetricScore = (ms)->
    #MetricScore.update({id: ms.id, score: ms.score})

  $scope.prevScore = (ms, prev_mss)->
    score = 0
    if prev_mss?
      for sc in prev_mss
        score = sc.score if ms.metric.id == sc.metric.id
    score
])

.controller("MetricScoreCtrl", ["$scope", "MetricScore", ($scope, MetricScore) ->
  $scope.metric_scores = MetricScore.query()
])
