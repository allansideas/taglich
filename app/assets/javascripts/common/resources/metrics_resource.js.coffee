angular.module('resources.metrics', ['ngResource'])

.factory("MetricScore", ["$resource", ($resource) ->
  $resource("days/:day_id/metric_scores/:id/", 
    {day_id: "@day_id", id: "@id"}, 
    {
      update: {method: "PUT"}
    }
  )
])

.factory("MetricScore", ["$resource", ($resource) ->
  $resource("metric_scores/:id/", 
    {id: "@id"}, 
    {
      update: {method: "PUT"}
    }
  )
])

.factory("MetricScoreIDs", ["$resource", ($resource) ->
  $resource("days/:day_id/metric_scores/only_ids/", 
    {day_id: "@day_id"}, 
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
