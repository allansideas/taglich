angular.module('states.day', [])
.config(['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
  $stateProvider.state('user.day',
    url: "/days/:date"
    views: 
      'main':
        template: "
          Day
          <section ui-view='act-flash-cards' class='l-widget'></section>
          <section ui-view='act-metrics' class='l-widget'></section>
          "
        controller: 'DayCtrl'
      'act-flash-cards@user.day':
        template: '
          <div flash-cards class="m-fl-cds" ng-show="!show_next">
            <article flash-card 
              ng-repeat="cId in cards.card_ids"
              c-id="cId" 
              class="m-fl-cd"
              ng-class="{\'is-visible\': $index === selected_index}" 
              ng-animate="{enter:\'fade-enter\'}"
              >
              </article>  
          </div>
          '
        controller: 'ActFlashCardsCtrl'
      'act-metrics@user.day':
        template: '
          <ul class="m-metrics l-ul-unstyled">
            <li class="m-row-i {{ms.status_class}}" metric-score ms-id="msId" ng-repeat="msId in metric_score_ids" ng-animate="{enter:\'fade-enter\'}"></li>
          </ul>
          '
        controller: 'ActMetricsCtrl'
  )
])
.controller("DayCtrl", ["$scope", "$rootScope", "$stateParams", "DayByDate", 'DateUtilsService', ($scope, $rootScope, $stateParams, DayByDate, DateUtilsService) ->
  console.log("--DayCtrl--( #{$stateParams.date} )")
  DayByDate.get_by_date({date: $stateParams.date}, (data)->
    $scope.$parent.active_day = data  
    $scope.$parent.next_day_url = DateUtilsService.getNextDay(data.date) 
    $scope.$parent.prev_day_url = DateUtilsService.getPrevDay(data.date) 

    $scope.$parent.show_next = (()->
      today = DateUtilsService.dateToUrl(new Date)
      if today == $scope.$parent.active_day.date
        return false
      else
        return true
    )()

    $scope.$parent.show_prev = (()->
      if $stateParams.date == $scope.$parent.current_user.first_day_created
        return false
      else
        return true
    )()
  )
])

