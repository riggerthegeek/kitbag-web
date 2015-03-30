'use strict'

###*
 # @ngdoc service
 # @name kitbagApp.formError
 # @description
 # # formError
 # Factory in the kitbagApp.
###
angular.module 'kitbagApp'
  .factory 'formError', ($modal) ->
    # Service logic
    # ...

    # Public API here
    {

      ###
       Open

       Opens a modal with the form error file
      ###
      open: (errorTitle) ->

        modalInstance = $modal.open
          templateUrl: 'views/controllers/formerror.html',
          controller: 'FormerrorCtrl'
          windowClass: 'spanky'
          resolve:
            errorTitle: ->
              errorTitle

        modalInstance.result

    }
