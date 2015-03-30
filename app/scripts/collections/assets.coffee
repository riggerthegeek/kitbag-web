'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:AssetsCollection
 # @description
 # # AssetsCollection
 # Collections of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'AssetsCollection', (Collection, AssetModel, lodash) ->



  class Assets extends Collection


    constructor: (data) ->

      @_model = AssetModel

      super data



  Assets
