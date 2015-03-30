'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:Organizations
 # @description
 # # Organizations
 # Collections of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'AssetTypesCollection', (Collection, AssetTypeModel, lodash) ->



  class Organizations extends Collection


    constructor: (data) ->

      @_model = AssetTypeModel

      super data



  Organizations
