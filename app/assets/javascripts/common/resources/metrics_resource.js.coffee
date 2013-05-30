angular.module('resources.metrics', ['ngResource'])

.factory("MetricScore", ["$resource", ($resource) ->
  $resource("/metric_scores/:id/", 
    {id: "@id"}, 
    {
      update: {method: "PUT"}
    }
  )
])

.factory("MetricScoresByDay", ["$resource", ($resource) ->
  $resource("/days/:year/:month/:verb", 
    {year: "@year", month: "@month", day: "@day"}, 
  )
])

.factory("Metric", ["$resource", ($resource) ->
  $resource("/metrics/:id/", 
    { id: "@id" }, 
    {
    sort: {method: 'POST'}, update: {method: "PUT"}
    }
  )
])

.factory("MetricSorter", ["$resource", ($resource) ->
  $resource("metrics/sort/?:metrics", 
    { metrics: '@metrics' }, 
    {
      sort: { method: 'POST'}
    }
  )
])
