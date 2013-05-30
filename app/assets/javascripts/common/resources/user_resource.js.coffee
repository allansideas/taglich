angular.module('resources.user', ['ngResource'])

.factory("User", ["$resource", ($resource) ->
  $resource("/users/:verb", {},
     {
       current: 
         method: 'GET', params: { verb: 'current' }
     }
  )
])
