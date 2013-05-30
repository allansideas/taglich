angular.module('states.day', [])
.config(['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
  $stateProvider.state('user.day',
    url: "/days/"
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
        template: 'metrics'
        controller: 'ActMetricsCtrl'
  )
])
.controller("DayCtrl", ["$scope", "$state", "User", ($scope, $state, User) ->
  console.log "DayCtrl"
  $scope.test = "Test"
])

