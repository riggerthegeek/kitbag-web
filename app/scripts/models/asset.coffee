'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:AssetModel
 # @description
 # # AssetModel
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'AssetModel', (lodash, Model) ->


  class AssetModel extends Model



    constructor: (data) ->

      super data

      # Set data
      @setOrganizationId @_data.organizationId



  AssetModel
