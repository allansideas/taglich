angular.module('states.user', [])
.config(['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
  $stateProvider.state('user',
    abstract: true
    views:
      '':
        template: "<div class='container' ui-view='nav'></div> <div class='container' ui-view='main'></div>"
        controller: "UserCtrl"
      'nav@user':
        template: '
          <a href="#/days/{{prev_day_url}}" ng-show="show_prev" >
            back
          </a>
          {{active_day.date}}
          <a href="#/days/{{next_day_url}}" ng-show="show_next" >
            next
          </a>
          '
  )
])
.controller("UserCtrl", ["$scope", "User", ($scope,  User) ->
  #Dates are set in day controller
  console.log "UserCtrl"
])
