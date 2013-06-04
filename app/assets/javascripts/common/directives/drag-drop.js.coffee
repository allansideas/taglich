angular.module('directives.drag_drop', [])
.directive "dndList", ->
  (scope, element, attrs) ->
    
    # variables used for dnd
    toUpdate = undefined
    startIndex = -1
    
    # watch the model, so we always know what element
    # is at a specific position
    scope.$watch attrs.dndList, ((value) ->
      toUpdate = []
      for v in value
        toUpdate.push(v.id)
    ), true
    
    # use jquery to make the element sortable (dnd). This is called
    # when the element is rendered
    $(element[0]).sortable
      items: ".m-row-i"
      handle: ".js-move-button"
      placeholder: "ui-state-highlight"
      opacity: 0.8
      update: ->
        scope.sort(toUpdate)
      start: (event, ui) ->
        # on start we define where the item is dragged from
        startIndex = ($(ui.item).index())

      stop: (event, ui) ->
        
        # on stop we determine the new index of the
        # item and store it there
        newIndex = ($(ui.item).index())
        toMove = toUpdate[startIndex]
        toUpdate.splice startIndex, 1
        toUpdate.splice newIndex, 0, toMove
        console.log toUpdate
        
        # we move items in the array, if we want
        # to trigger an update in angular use $apply()
        # since we're outside angulars lifecycle
        scope.$apply scope.metrics
      axis: "y"
