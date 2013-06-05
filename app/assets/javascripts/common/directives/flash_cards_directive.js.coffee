angular.module('directives.flash_cards', [])
.directive("flashCards", ["$http", "$compile", "FlashCard", ($http, $compile, FlashCard)->
  restrict: "A"
  require: "?ngModel"
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - FlashCards**") 

    scope.wrapper_el = element
    FlashCard.query((data)->
      scope.cards = data
      scope.cards.last_incorrect = undefined
      #Maybe move this to rootscope so when switching between settings...etc the right card will be displayed
      #Also need to consider that maybe it would get updated when its shown then when the state changes back
      rand = ()->
        Math.floor(Math.random() * (scope.cards.length))
      scope.selected_index = rand()
      FlashCard.update_seen({id: scope.cards[scope.selected_index].id})

      scope.next = ()->
        scope.selected_index = rand()
        while scope.cards[scope.selected_index].id == scope.cards.last_incorrect
          scope.selected_index = rand()
        if scope.cards.length != 0
          FlashCard.update_seen({id: scope.cards[scope.selected_index].id})
      )
])
