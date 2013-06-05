angular.module('directives.metric', [])
.directive("metric", ["Metric", "DateUtilsService", (Metric, DateUtilsService)->
  restrict: "A"
  require: "?ngModel"
  templateUrl: 'templates/metrics/edit_metric.html'
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - Metric**")
    scope.updateState = (index)->
      scope.$parent.metrics.splice(index, 1)
      Metric.update({id: scope.metric.id, state: 'inactive', deactivated_on: DateUtilsService.dateToUrl(new Date())}, (data)->
      )
])
