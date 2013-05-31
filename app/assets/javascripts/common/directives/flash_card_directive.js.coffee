angular.module('directives.flash_card', [])
.directive("flashCard", ["FlashCard", (FlashCard)->
  restrict: "A"
  require: "?ngModel, $http"
  templateUrl: '/templates/metrics/act_metric.html'
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - FlashCard**")
    console.log scope
    #scope.ms = MetricScore.get({id: scope.msId}, ()->)

    #updateAfterWatch = ()->
      #scope.ms = MetricScore.update(scope.ms)

    #debouncedUpdateMS = uiDebounce(updateAfterWatch, 300, false)

    #scope.$watch('ms.score', (new_val, old_val)->
      #if ((new_val != old_val) && old_val != undefined)
        #debouncedUpdateMS()
    #, true)
])
