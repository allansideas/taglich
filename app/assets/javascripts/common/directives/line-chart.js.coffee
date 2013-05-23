angular.module('directives.line_chart', [])
.directive("lineChart", ["$http", ($http)->
  restrict: "A"
  require: "?ngModel, $http"
  link: (scope, element, attr, controller) ->

    options = {}
    getOptions = ->
      angular.extend {}, options, scope.$eval(attr.fltLinechartoptions)

    init = (ms) ->
      $http(
        method: "GET"
        url: "/metric_scores/"+ms.id+"/graph_data"
      ).success((data, status, headers, config) ->
        d1 = data
        console.log data
        if data.length > 1
          temp_options = getOptions()

          drawGraph = (opts)->
            o = Flotr._.extend(Flotr._.clone(temp_options), opts or {})
            Flotr.draw element[0], [d1], o

          element.hide()
          element.fadeIn()
          graph = drawGraph()
        else
          console.log "HI"
          element[0].innerHTML = "<p class='data-msg'>" + ms.metric.name + ": Not enough data yet </p>"
          element.fadeIn()
      )

    data = scope[attr.ngModel]
    scope.$watch "data", init(data)
])

