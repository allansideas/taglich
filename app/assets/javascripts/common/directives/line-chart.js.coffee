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
        if data.length > 1
          temp_options = getOptions()

          drawGraph = (opts)->
            o = Flotr._.extend(Flotr._.clone(temp_options), opts or {})
            Flotr.draw element[0], [d1], o

          scope.graph = drawGraph()

        else
          return
          #element[0].innerHTML = "<p class='data-msg'>" + ms.metric.name + ": Not enough data yet </p>"
          #element.fadeIn()
      )

    scope.$watch "ms", (new_val, old_val)->
      init(new_val)
])


