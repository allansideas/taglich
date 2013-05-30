angular.module('states.user', [])
.config(['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
  $stateProvider.state('user',
    abstract: true
    views:
      '':
        template: "<div class='container' ui-view='nav'></div> <div class='container' ui-view='main'></div>"
        controller: "UserCtrl"
      'nav@user': 
        template: "Nav"
        controller: "UserNavCtrl"
        
  )
])
.controller("UserCtrl", ["$scope", "User", ($scope,  User) ->
  console.log "UserCtrl"
])
.controller("UserNavCtrl", ["$scope", ($scope) ->
  console.log 'NavCtrl'
])
