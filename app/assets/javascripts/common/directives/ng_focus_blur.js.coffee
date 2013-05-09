angular.module('directives.ng_focus_blur', [])
.directive("ngFocus", ["$parse", ($parse) ->
  (scope, element, attr) ->
    fn = $parse(attr["ngFocus"])
    element.bind "focus", (event) ->
      scope.$apply ->
        fn scope,
          $event: event
])

.directive("ngBlur", ["$parse", ($parse) ->
  (scope, element, attr) ->
    fn = $parse(attr["ngBlur"])
    element.bind "blur", (event) ->
      scope.$apply ->
        fn scope,
          $event: event
])
