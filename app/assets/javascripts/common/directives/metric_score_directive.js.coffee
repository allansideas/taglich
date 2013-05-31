angular.module('directives.metric_score', [])
.directive("metricScore", ["MetricScore", "uiDebounce", (MetricScore, uiDebounce)->
  restrict: "A"
  require: "?ngModel, $http"
  templateUrl: '/templates/metrics/act_metric.html'
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - MetricScore**")
    id = scope.msId
    scope.blank_val = false
    scope.ms = MetricScore.get({id: id}, ()->)

    updateAfterWatch = ()->
      if scope.ms.score == null
        element.children('.actors').children('input').addClass('is-invalid')
        return
      else
        element.children('.actors').children('input').removeClass('is-invalid')
        scope.ms = MetricScore.update(scope.ms)

    debouncedUpdateMS = uiDebounce(updateAfterWatch, 500, false)

    scope.$watch('ms.score', (new_val, old_val)->
      if ((new_val != old_val) && old_val != undefined)
        if new_val == null
          element.children('.actors').children('input').addClass('is-invalid')
        else
          element.children('.actors').children('input').removeClass('is-invalid')
          debouncedUpdateMS()
    , true)
])
