angular.module('states.day', [])
.config(['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
  $stateProvider.state('user.day',
    url: "/days/:date"
    views: 
      'main':
        template: "
          Day
          <div ui-view='act-flash-cards'></div>
          <div ui-view='act-metrics'></div>
          "
        controller: 'DayCtrl'
      'act-flash-cards@user.day':
        template: '
          <div flash-cards >
            <div flash-card 
              ng-repeat="cId in cards.card_ids"
              c-id="cId" 
              class="card"
              ng-class="{\'is-visible\': $index === selected_index}" 
              ng-animate="{enter:\'fade-enter\'}"
              >
              </div>  
          </div>
          '
        controller: 'ActFlashCardsCtrl'
      'act-metrics@user.day':
        template: '
          <ul ng-repeat="msId in metric_score_ids" ng-animate="{enter:\'fade-enter\'}">
            <li metric-score ms-id="msId"></li>
          </ul>
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

