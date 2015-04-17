'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.directive:kbActionMenu
 # @description
 # # Action Menu directive
###
angular.module('kitbagApp')
.directive 'kbActionMenu', ($state, lodash) ->


  link: (scope) ->

    # Default the add new button to true
    scope.displayAddNew = if lodash.isBoolean(scope.addNew) then scope.addNew else true

    # Create the cancel function
    scope.cancelFunction = ->

      if lodash.isString scope.cancelState
        # Go to the cancel state
        fn = ->
          $state.go scope.cancelState

      else
        # Reload this state
        fn = ->
          $state.reload()

      fn()


  restrict: 'E'


  replace: true


  scope:
    addNew: '='
    cancelState: '='
    form: '='
    submit: '='


  templateUrl: 'views/directives/actionMenu.html'
