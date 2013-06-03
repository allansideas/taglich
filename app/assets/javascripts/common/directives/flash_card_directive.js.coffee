angular.module('directives.flash_card', [])
.directive("flashCard", ["FlashCard", "FlickrImageSearchService", (FlashCard, FlickrImageSearchService, $http)->
  restrict: "A"
  require: "?ngModel, FlickrImageSearchService"
  template: "
    <div class='card-flickr-img'></div>
    <div class='card-front' ng-show='face === 0'>{{card.front}}</div>
    <div class='card-back' ng-show='face === 1' >{{card.back}}</div>
    <div>
      <div>
        <a ng-click='flip()'>Flip it</a>
      </div>
      <div>
        <a ng-click='correct()'>Got it</a>
      </div>
      <div>
        <a ng-click='incorrect()'>Sheeeeeit</a>
      </div>
    </div>
    "
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - FlashCard**") 
    id = scope.cId
    scope.card = FlashCard.get({id: id}, ()->
      scope.face = 0
      word_from_card = scope.card.front.split(' ')[0]
      FlickrImageSearchService.getPhoto("#{word_from_card}").then((data)->
        images_in_array = 5
        rand = Math.floor(Math.random() * (images_in_array - 1))
        scope.images = data[0]
        scope.image = scope.images[rand]
        element.children('.card-flickr-img').append('<img src="' + scope.image.src + '"/>')
      )
    )

    scope.flip = ()->
      scope.face = if scope.face == 0 then 1 else 0


    scope.correct = ()->
      FlashCard.update_score({id: scope.cards.card_ids[scope.selected_index], score: "correct"})
      scope.cards.card_ids.splice(scope.selected_index, 1)
      unless scope.cards.card_ids.length == 0
        scope.next()
      else
        scope.wrapper_el.html("Finished")


    scope.incorrect = ()->
      scope.cards.last_incorrect = scope.card.id
      if scope.cards.card_ids.length
        FlashCard.update_score({id: scope.cards.card_ids[scope.selected_index], score: "incorrect"})
        scope.next()
])
