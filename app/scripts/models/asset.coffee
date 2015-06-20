'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:AssetModel
 # @description
 # # AssetModel
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'AssetModel', (lodash, AssetTypeModel, Model) ->


  class AssetModel extends Model



    constructor: (data) ->

      super data

      @serialNumber = @_data.serialNumber || null
      @currentLocation = @_data.currentLocation || null
      @returnRequested = Model.setBool @_data.returnRequested, false
      @lastMaintenanceDate = Model.setDate @_data.lastMaintenanceDate, null
      @purchaseDate = Model.setDate @_data.purchaseDate, null
      @type = @setType @_data.type


      # Set data
      @setOrganizationId @_data.organizationId


    getCurrentLocation: ->
      @currentLocation


    getLastMaintenanceDate: ->
      @lastMaintenanceDate


    getOrganizationId: ->
      @organizationId


    getPurchaseDate: ->
      @purchaseDate


    getReturnRequested: ->
      @returnRequested


    getSerialNumber: ->
      @serialNumber


    getType: ->
      @type


    setOrganizationId: (organizationId) ->
      @organizationId = Model.setString organizationId, null
      @


    setType: (type) ->
      @type = new AssetTypeModel type
      @


    @toModel = (data) ->

      obj = super(data)

      if lodash.isObject(data) && lodash.isObject(data.type)
        obj.type = AssetTypeModel.toModel data.type

      obj


  AssetModel
