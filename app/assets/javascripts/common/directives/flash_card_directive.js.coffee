angular.module('directives.flash_card', [])
.directive("flashCard", ["FlashCard", "FlickrImageSearchService", (FlashCard, FlickrImageSearchService, $http)->
  restrict: "A"
  require: "?ngModel, FlickrImageSearchService"
  template: "
    <div class='m-fl-cd-flickr-img' ng-show='show_flickr'></div>
    <div class='m-fl-cd-front' ng-show='face === 0'>{{card.front}}</div>
    <div class='m-fl-cd-back' ng-show='face === 1' >{{card.back}}</div>
    <div class='l-row'>
      <div class='btn-neutral g-third' ng-click='flip()'>
        Flip it
      </div>
      <div class='btn-positive g-third' ng-click='correct()'>
        Got it
      </div>
      <div class='btn-negative g-third' ng-click='incorrect()'>
        Sheeeeeit
      </div>
    </div>
    "
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - FlashCard**") 
    scope.show_flickr = false
    scope.face = 0
    if scope.show_flickr == true
      word_from_card = scope.card.front.split(' ')[0]
      FlickrImageSearchService.getPhoto("#{word_from_card}").then((data)->
        images_in_array = 5
        rand = Math.floor(Math.random() * (images_in_array - 1))
        scope.images = data[0]
        scope.image = scope.images[rand]
        element.children('.m-fl-cd-flickr-img').css('background-image', "url(#{scope.image.src})")
      )

    scope.flip = ()->
      scope.face = if scope.face == 0 then 1 else 0


    scope.correct = ()->
      FlashCard.update_score({id: scope.card.id, score: "correct"})
      scope.cards.splice(scope.selected_index, 1)
      unless scope.cards.length == 0
        scope.next()
      else
        scope.wrapper_el.html("Finished")


    scope.incorrect = ()->
      scope.cards.last_incorrect = scope.card.id
      if scope.cards.length
        FlashCard.update_score({id: scope.card.id, score: "incorrect"})
        scope.next()
])
