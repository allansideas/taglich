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
            <div settings-flash-cards>
            </div>
          '
        controller: 'SettingsFlashCardsCtrl'
      'settings-metrics@user.settings':
        templateUrl: 'templates/metrics/settings_metrics.html'
        controller: 'SettingsMetricsCtrl'
  )
])
.controller("UserSettingsCtrl", ["$scope", "$rootScope", "$stateParams", "DayByDate", 'DateUtilsService', ($scope, $rootScope, $stateParams, DayByDate, DateUtilsService) ->
  console.log("--UserSettingsCtrl--")
            #<li metric class="m-row-i" m-id="mId" ng-repeat="mId in metrics" ng-animate="{enter:\'fade-enter\'}"></li>
])
.controller("SettingsFlashCardsCtrl", [()->
])
.controller("SettingsMetricsCtrl", ["$scope", "Metric", "MetricSorter", "MetricScore", ($scope, Metric, MetricSorter, MetricScore)->
  $scope.is_adding = false
  $scope.n_metric = {}
  $scope.cancel = ()->
    $scope.n_metric = {}
    $scope.is_adding = false
  $scope.save = ()->
    $scope.n_metric.state = 'active'
    console.log $scope.current_user
    Metric.save({user_id: $scope.current_user.id}, $scope.n_metric, (data)->
      MetricScore.save({metric_id: data.id, day_id: $scope.current_user.last_day_created.id}, (data)->
        $scope.is_adding = false
        $scope.metrics.unshift(data)
        $scope.n_metric = {}
      )
    )
  $scope.metrics = Metric.query()
  $scope.sort = (params)->
    MetricSorter.sort(metrics: params)
])

