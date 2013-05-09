app = angular.module("Taglich", [
  'ui.compat',
  'dates_times',
  'metrics',
  'directives.ng_focus_blur'
  'directives.drag_drop'
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
