'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.directive:kbActionMenu
 # @description
 # # Action Menu directive
###
angular.module('kitbagApp')
.directive 'kbActionMenu', ($q, $state, lodash, $rootScope) ->


  link: (scope, element, attrs, formCtrl) ->

    # Default the add new button to true
    scope.displayAddNew = if lodash.isBoolean(scope.addNew) then scope.addNew else true


    scope.submitFunction = (addNew) ->

      $rootScope.$broadcast 'schemaFormValidate'

      formCtrl.addNew = if lodash.isBoolean(addNew) then addNew else false


    # Create the cancel function
    scope.cancelFunction = ->

      if lodash.isString scope.cancelState
        # Go to the cancel state
        $state.go scope.cancelState

      else
        # Reload this state
        $state.reload()


  require: '^form'


  restrict: 'E'


  scope:
    addNew: '='
    cancelState: '='


  templateUrl: 'views/directives/actionMenu.html'
