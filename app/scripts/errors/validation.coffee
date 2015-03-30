'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:ValidationError
 # @description
 # # ValidationError
 # Factory of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'ValidationError', (lodash) ->


  class Validation extends Error

    constructor: (message) ->

      super message

  Validation
