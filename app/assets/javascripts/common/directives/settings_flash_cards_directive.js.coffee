angular.module('directives.settings_flash_cards', [])
.directive("settingsFlashCards", ["CardSet", (CardSet)->
  restrict: "A"
  require: "?ngModel"
  template: '
      <div class="btn btn-positive btn-icon-text l-row" ng-click="is_adding = true" ng-show="!is_adding">
        <i class="foundicon-plus"></i> 
        <span>New Card Set</span>
      </div>
      <div class="m-box m-box-padded m-box-boring l-widget">
        <input 
        class="l-row"
        type="text" 
        ng-model="n_cs.name" 
        placeholder="Card Set Name" 
        />
        <div class="btn btn-negative g-third" ng-click="cancel()">
          Cancel
        </div>
        <div class="btn btn-positive" 
          ng-click="saveCardSet()"
          >
          Save
        </div>
      </div>
      <ul class="l-ul-unstyled">
        <li settings-card-set ng-repeat="cs in card_sets" class="m-row-i"></li>
      </ul>
    '
  link: (scope, element, attr, controller) ->
    console.log ("**Directive - SettingsFlashCards**") 
    $scope.is_adding = false
    n_cs = {}
    $scope.cancelCs = ()->
      $scope.n_cs = {}
      $scope.is_adding = false

    scope.card_sets = CardSet.query()
])
