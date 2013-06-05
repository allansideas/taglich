angular.module('directives.metric_score', [])
.directive("metricScore", ["MetricScore", "uiDebounce", (MetricScore, uiDebounce)->
  restrict: "A"
  require: "?ngModel, $http"
  templateUrl: '/templates/metrics/act_metric.html'
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - MetricScore**")

    validateNumberInput = ()->
      if scope.ms.score == null
        element.children('.js-in-num').addClass('is-invalid')
        return
      else
        element.children('.js-in-num').removeClass('is-invalid')
        scope.updateScore()

    scope.updateScore = ()->
      scope.ms = MetricScore.update(scope.ms, (ms)->
        setRowStatus(ms)
      )
    scope.last_score = (()->
      if scope.ms?
        if scope.ms.last_8[scope.ms.last_8.length - 2]?
          last_score = scope.ms.last_8[scope.ms.last_8.length - 2].score
        else
          last_score = 0
      )()

    setRowStatus = (ms)->
      is_bool = ms.score_type == "boolean" 
      score = ms.score
      last_score = scope.last_score

      scope.ms.status_class = "is-neutral-row"
      if ms.last_8.length > 0?
        if score > last_score or is_bool and score == 1
          scope.ms.status_class = "is-positive-row"
        if score > 0 && score < last_score && !is_bool
          scope.ms.status_class = "is-okay-row"

    setRowStatus(scope.ms)

    updateAfterWatch = ()->
      validateNumberInput()

    debouncedUpdateMS = uiDebounce(updateAfterWatch, 500, false)

    scope.$watch('ms.score', (new_val, old_val)->
      if ((new_val != old_val) && old_val != undefined)
        if new_val == null
          element.children('.js-in-num').addClass('is-invalid')
        else
          element.children('.js-in-num').removeClass('is-invalid')
          debouncedUpdateMS()
    , true)
])
