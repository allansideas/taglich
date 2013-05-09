angular.module('resources.dates_times', ['ngResource'])
angular.module('resources.dates_times')
  .factory("Day", ["$resource", ($resource) ->
    $resource("/days/:id", { id: "@id" }, { update: { method: "PUT" } })
  ])

  .factory("DayByDate", ["$resource", ($resource) ->
    $resource("/days/:year/:month/:day", { year: "@date", month: "@month", day: "@day" })
  ])

  #.factory("Week", ["$http", ($http) ->
    #$http.get('days/current_week').then((response)->
      #response.data
    #)
  #])

