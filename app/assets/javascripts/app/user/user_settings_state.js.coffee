angular.module('states.user.settings', [])
.config(['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
  $stateProvider.state('user.settings',
    url: "/user/settings"
    views: 
      'main':
        template: "
          <section ui-view='settings-flash-cards' class='l-widget'></section>
          <section ui-view='settings-metrics' class='l-widget'></section>
          "
        controller: 'UserSettingsCtrl'
      'settings-flash-cards@user.settings':
        template: '
            set flash
          '
        controller: 'SettingsFlashCardsCtrl'
      'settings-metrics@user.settings':
        template: '
          <ul dnd-list="metrics" class="m-metrics l-ul-unstyled">
            <li metric 
              ng-repeat="metric in metrics"
              class="m-row-i"
            >
            </li>
          </ul>
          '
        controller: 'SettingsMetricsCtrl'
  )
])
.controller("UserSettingsCtrl", ["$scope", "$rootScope", "$stateParams", "DayByDate", 'DateUtilsService', ($scope, $rootScope, $stateParams, DayByDate, DateUtilsService) ->
  console.log("--UserSettingsCtrl--")
            #<li metric class="m-row-i" m-id="mId" ng-repeat="mId in metrics" ng-animate="{enter:\'fade-enter\'}"></li>
])
.controller("SettingsFlashCardsCtrl", [()->
])
.controller("SettingsMetricsCtrl", ["$scope", "Metric", "MetricSorter", ($scope, Metric, MetricSorter)->
  $scope.metrics = Metric.query()
  $scope.sort = (params)->
    MetricSorter.sort(metrics: params)
])

