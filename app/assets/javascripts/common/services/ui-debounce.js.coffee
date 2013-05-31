angular.module('services.ui_debounce', [])
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

