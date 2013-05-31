angular.module('resources.days', ['ngResource'])
angular.module('resources.days')
.factory("Day", ["$resource", ($resource) ->
  $resource("/days/:id", { id: "@id" }, { update: { method: "PUT" } })
])

.factory("DayByDate", ["$resource", ($resource) ->
  $resource("/days/:date/:verb", 
    { date: "@date" },
    {
       metric_scores: 
         method: 'GET', params: { verb: 'metric_scores' }, isArray: true
       get_by_date: 
         method: 'GET', params: { verb: 'get_by_date' }
    }
  )
])

  #.factory("Week", ["$http", ($http) ->
    #$http.get('days/current_week').then((response)->
      #response.data
    #)
  #])

