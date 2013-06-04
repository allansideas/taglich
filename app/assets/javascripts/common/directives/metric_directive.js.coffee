angular.module('directives.metric', [])
.directive("metric", ["Metric", "DateUtilsService", (Metric, DateUtilsService)->
  restrict: "A"
  require: "?ngModel"
  template: '
    <div class="l-f-left btn btn-boring-darker m-row-i-input-narrow js-move-button">
      <i class="foundicon-up-arrow"></i>
      <i class="foundicon-down-arrow"></i>
    </div>
    <label class="m-row-i-label">
    {{metric.name}}
    </label>
    <div 
      class="l-f-right btn btn-negative m-row-i-input-narrow"
      ng-click="updateState($index)"
      >
      <i class="foundicon-remove"></i>
    </div>
  '
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - Metric**")
    console.log scope.metric
    scope.updateState = (index)->
      scope.$parent.metrics.splice(index, 1)
      Metric.update({id: scope.metric.id, state: 'inactive', deactivated_on: DateUtilsService.dateToUrl(new Date())}, (data)->
      )
])
