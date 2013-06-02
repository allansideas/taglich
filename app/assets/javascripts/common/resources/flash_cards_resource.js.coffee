angular.module('resources.flash_cards', ['ngResource'])
angular.module('resources.flash_cards')

  .factory("FlashCard", ["$resource", ($resource) ->
    $resource("/cards/:id/:verb", { id: "@id" }, 
       {
         update_seen: 
           method: 'PUT', params: { verb: 'update_seen' }
         update_score: 
           method: 'PUT', params: { verb: 'update_score' }
       }
    )
  ])

  .factory("CardSet", ["$resource", ($resource) ->
    $resource("/card_sets/:id", {id: "@id"}, {save: {method: 'POST', isArray: true}})
  ])

