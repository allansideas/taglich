angular.module('directives.line_chart', [])
.directive "lineChart", ($http)->
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

        temp_options = getOptions()

        drawGraph = (opts)->
          o = Flotr._.extend(Flotr._.clone(temp_options), opts or {})
          Flotr.draw element[0], [d1], o

        graph = drawGraph()
      )

    data = scope[attr.ngModel]
    scope.$watch "data", init(data)


