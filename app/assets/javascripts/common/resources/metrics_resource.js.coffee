angular.module('resources.metrics', ['ngResource'])

.factory("MetricScore", ["$resource", ($resource) ->
  $resource("/metric_scores/:id/", {id: "@id"}, {update: {method: "PUT"}})
])

.factory("UserMetric", ["$resource", ($resource) ->
  $resource("/users/:uid/metrics/:id/", {uid: "@uid", id: "@id"}, {sort: {method: 'POST'}, update: {method: "PUT"}})
])

#.factory("Metric", ["$resource", ($resource) ->
  #$resource("metrics/:id",{id: '@id'}, {sort: { url: '/sort', method: 'POST'}})
#])

.factory("MetricSorter", ["$resource", ($resource) ->
  $resource("metrics/sort/?:metrics", {metrics: '@metrics'}, {sort: { method: 'POST'}})
])
