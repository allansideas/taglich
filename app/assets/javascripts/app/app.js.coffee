app = angular.module("Taglich", [
  'ui.compat',
  'dates_times',
  'resources.metrics',
  'resources.flash_cards',
  'directives.ng_focus_blur'
  'directives.drag_drop'
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

app.config(["$httpProvider", "$anchorScrollProvider", (provider, $anchorScrollProvider)-> 
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  $anchorScrollProvider.disableAutoScrolling()
])

app.run(["$rootScope", "$state", "$stateParams", "$templateCache", ($rootScope, $state, $stateParams, $templateCache) ->
  $rootScope.pageTitle = "Taglich"
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
])
