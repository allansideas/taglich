app = angular.module("Taglich", [
  'ui.compat',
  'resources.user',
  'resources.metrics',
  'services.user',
  'services.date_utils',
  #'views.nav'
  'states.user',
  'states.day',
  #'dates_times',
  #'resources.metrics',
  #'resources.flash_cards',
  'directives.ng_focus_blur',
  'directives.drag_drop',
  'directives.line_chart'
])
.factory("uiDebounce", ["$timeout", "$q", ($timeout, $q) ->
  (func, wait, immediate) ->
    timeout = undefined
    deferred = $q.defer()
    return ()->
      context = this
      args = arguments
      later = ->
        timeout = null
        unless immediate
          deferred.resolve func.apply(context, args)
          deferred = $q.defer()

      callNow = immediate and not timeout
      $timeout.cancel timeout  if timeout
      timeout = $timeout(later, wait)
      if callNow
        deferred.resolve func.apply(context, args)
        deferred = $q.defer()
      deferred.promise
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
