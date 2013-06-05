angular.module('directives.settings_card_set', [])
.directive("settingsCardSet", ["FlashCard", "CardSet", "FlickrImageSearchService", (FlashCard, CardSet, FlickrImageSearchService)->
  restrict: "A"
  require: "?ngModel, FlickrImageSearchService"
  template: '
    <div class="m-row-i-label">
      <span class="m-row-i-stat">
      <small><i class="foundicon-page smaller"></i></small> 
      {{cs.total_cards}}
      </span> 
      {{cs.name}}
    </div>
    <div 
      class="btn btn-negative m-row-i-input-narrow l-f-right" 
      ng-click="ms.score = 1 - ms.score"
      >
      <i class="foundicon-remove" ></i>
    </div>
    <div 
      class="btn btn-positive btn-icon-text l-f-right" 
      ng-click=""
      >
      <i class="foundicon-plus" ></i>
      <span>Add cards</span>
    </div>
    '
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - SettingsFlashCards**") 

])
