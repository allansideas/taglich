angular.module('directives.metric_score', [])
.directive("metricScore", ["MetricScore", "uiDebounce", (MetricScore, uiDebounce)->
  restrict: "A"
  require: "?ngModel, $http"
  templateUrl: '/templates/metrics/act_metric.html'
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - MetricScore**")
    scope.ms = MetricScore.get({id: scope.msId}, ()->)


    updateAfterWatch = ()->
      console.log "twt"
     #MetricScore.update({id: ms.id, score: ms.score}, (data)->
         #metric = data.metric.sort_order - 1
         #$scope.day.metric_scores[metric].streak = data.streak
       #)
      scope.ms = MetricScore.update({day_id: scope.$parent.active_day.id}, scope.ms)

      

    debouncedUpdateMS = uiDebounce(updateAfterWatch, 300, false)

    scope.$watch('ms.score', (new_val, old_val)->
      if ((new_val != old_val) && old_val != undefined)
        debouncedUpdateMS()
    , true)
])
