angular.module('states.day', [])
.config(['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
  $stateProvider.state('user.day',
    url: "/days/:date"
    views: 
      'main':
        template: "
          Day
          <div ui-view='act-metrics'></div>
          <div ui-view='act-flash-cards'></div>
          "
        controller: 'DayCtrl'
      'act-flash-cards@user.day':
        template: 'flash'
        controller: 'ActFlashCardsCtrl'
      'act-metrics@user.day':
        template: '
          <div ng-repeat="msId in metric_score_ids" ng-animate="{enter:\'fade-enter\'}">
            <div metric-score ms-id="msId"></div>
          </div>
          '
        controller: 'ActMetricsCtrl'
  )
])
.controller("DayCtrl", ["$scope", "$stateParams", "DayByDate", 'DateUtilsService', ($scope, $stateParams, DayByDate, DateUtilsService) ->
  console.log("--DayCtrl--( #{$stateParams.date} )")
  DayByDate.get_by_date({date: $stateParams.date}, (data)->
    $scope.active_day = data  
  )
])

