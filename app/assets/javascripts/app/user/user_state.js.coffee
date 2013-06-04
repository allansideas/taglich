angular.module('states.user', [])
.config(['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
  $stateProvider.state('user',
    abstract: true
    views:
      '':
        template: "
          <div style='font-size: 12px; color: #111; width: 300px; position: absolute; left:0; top:0; padding: 15px; background: #ccc;'>
            {{$state.current.name}}
          </div>
          <nav class='l-row' ui-view='nav'></nav> 
          <div ui-view='main'></div>
        "
        controller: "UserCtrl"
      'nav@user':
        template: '
          <a class="btn btn-neutral" 
            href="#/days/{{prev_day_url}}" 
            ng-show="show_prev" 
            >
            <i class="foundicon-left-arrow"></i>
          </a>
          <span>{{active_day.date}}</span>
          <a class="btn btn-neutral" 
            href="#/days/{{next_day_url}}" 
            ng-show="show_next" 
            >
            <i class="foundicon-right-arrow"></i>
          </a>
          <a href="#/days/{{todays_date_url}}/graphs" 
            ng-class="{\'btn-is-selected\': $state.includes(\'user.day\')}" 
            class="l-f-right btn btn-boring btn-nav" 
            >
            <i class="foundicon-graph"></i>
          </a>
          <a href="#/user/settings" 
            ng-class="{\'btn-is-selected\': $state.current.name == \'user.settings\'}"
            class="l-f-right btn btn-boring btn-nav" 
            >
            <i class="foundicon-settings"></i>
          </a>
          <a href="#/days/{{todays_date_url}}" 
            ng-class="{\'btn-is-selected\': $state.current.name == \'user.day\'}" 
            class="l-f-right btn btn-boring btn-nav" 
            >
            <i class="foundicon-edit"></i>
          </a>
          '
  )
])
.controller("UserCtrl", ["$scope", "User", ($scope,  User) ->
  #Dates are set in day controller
  console.log "UserCtrl"
])
