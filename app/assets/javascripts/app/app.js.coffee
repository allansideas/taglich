app = angular.module("Taglich", [
  'ui.compat',
  'resources.user',
  'resources.metrics',
  'resources.days',
  #'services.user',
  'services.date_utils',
  'services.ui_debounce',
  #'views.nav'
  'states.user',
  'states.day',
  'states.day.flash_cards_controller',
  'states.day.metrics_controller',
  #'dates_times',
  #'resources.flash_cards',
  'directives.metric_score',
  'directives.ng_focus_blur',
  'directives.drag_drop',
  'directives.line_chart'
])
app.config(["$httpProvider", "$anchorScrollProvider", '$urlRouterProvider', ($httpProvider, $anchorScrollProvider, $urlRouterProvider)-> 
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  $anchorScrollProvider.disableAutoScrolling()
  date = new Date()
  normalizeDate = (date)->
    date.replace(/\b(\d{1})\b/g, '0$1')
  $urlRouterProvider.otherwise("/days/" + date.getFullYear() + "/" + normalizeDate((1 + date.getMonth()).toString()) + "/" + normalizeDate(date.getDate().toString()) )
])

#['$stateProvider', '$routeProvider', '$urlRouterProvider', ($stateProvider, $routeProvider, $urlRouterProvider)->
app.run(["$rootScope", "$state", "$stateParams", "$templateCache",  "User", ($rootScope, $state, $stateParams, $templateCache, User) ->
  $rootScope.pageTitle = "Taglich"
  User.current((data)->
    $rootScope.current_user = data  
  )
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
])
