angular.module('directives.flash_cards', [])
.directive("flashCards", ["$http", "$compile", "FlashCard", ($http, $compile, FlashCard)->
  restrict: "A"
  require: "?ngModel"
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - FlashCards**") 
    scope.wrapper_el = element

    $http(
      method: "GET"
      url: "/cards/only_ids"
    ).success((data, status, headers, config) ->
      scope.cards = {}
      scope.cards.card_ids = data
      scope.cards.last_incorrect = undefined
      #Maybe move this to rootscope so when switching between settings...etc the right card will be displayed
      #Also need to consider that maybe it would get updated when its shown then when the state changes back
      rand = ()->
        Math.floor(Math.random() * (scope.cards.card_ids.length))
      scope.selected_index = rand()
      FlashCard.update_seen({id: scope.cards.card_ids[scope.selected_index]})

      scope.next = ()->
        scope.selected_index = rand()
        while scope.cards.card_ids[scope.selected_index] == scope.cards.last_incorrect
          scope.selected_index = rand()
        if scope.cards.card_ids.length != 0
          FlashCard.update_seen({id: scope.cards.card_ids[scope.selected_index]})

    )
])
