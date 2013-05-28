angular.module('resources.flash_cards', ['ngResource'])
angular.module('resources.flash_cards')
  .factory("UserCardScore", ["$resource", ($resource) ->
    $resource("/users/:user_id/card_scores/:card_id/:verb", { user_id: "@user_id", card_id: "@card_id" }, 
       {
         update_seen: 
           method: 'POST', params: { verb: 'update_seen' }
         update_score: 
           method: 'POST', params: { verb: 'update_score' }
       }
    )
  ])
  .factory("CardSet", ["$resource", ($resource) ->
    $resource("/card_sets/:id", {id: "@id"})
  ])

