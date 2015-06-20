'use strict'

###*
 # @ngdoc service
 # @name kitbagApp.engine
 # @description
 # # engine
 # Factory in the kitbagApp.
###
angular.module 'kitbagApp'
.factory 'engine', ($q, api, authentication) ->


  {



    allAssets: (organizationId, assetTypeId) ->

      url = 'asset?organizationId=' + organizationId

      if assetTypeId
        # The assetTypeId parameter is optional - returns all asset types otherwise
        url += '&typeId=' + assetTypeId

      api.callURL 'get', url




    allAssetTypes: (organizationId) ->

      api.callURL 'get', 'asset/type?organizationId=' + organizationId



    deleteOrganization: (organizationId) ->

      # @todo connect this to the API
      $q (resolve, reject) ->
        setTimeout ->
          resolve()
        , 50




    getAssetType: (organizationId, assetTypeId) ->

      api.callURL 'get', 'asset/type/' + assetTypeId + '?organizationId=' + organizationId



    login: (emailAddress, password, rememberMe) ->

      api.callURL 'post', 'system/web',
        emailAddress: emailAddress,
        password: password
      , false
        .then (data) ->

          # Success - store the sessionId
          authentication.setAuthKey data.sessionId, rememberMe

        .catch (obj) ->

          # Failed - clear the sessionId
          authentication.clearAuthKey()

          status = if obj.status == 401 then 'UNAUTHORIZED' else 'UNKNOWN_ERR'

          $q.reject status



    myOrganizations: ->

      api.callURL 'get', 'organization'



    organization: (organizationId) ->

      api.callURL 'get', 'organization/' + organizationId



    saveAsset: (data) ->

      obj =
        serialNumber: data.getSerialNumber()
        currentLocation: data.getCurrentLocation()
        returnRequested: data.getReturnRequested()
        lastMaintenanceDate: data.getLastMaintenanceDate()
        purchaseDate: data.getPurchaseDate()
        type: data.getType()

      if data.getId() == null
        # Create new asset
        api.callURL 'post', 'asset?organizationId=' + data.getOrganizationId(), obj
      else
        # Edit existing asset
        api.callURL 'put', 'asset/' + data.getId() + '?organizationId=' + data.getOrganizationId(), obj



    saveAssetType: (data) ->

      obj =
        manufacturer: data.getManufacturer()
        model: data.getModel()
        maintenanceSchedule: data.getMaintenanceSchedule()
        organizationId: data.getOrganizationId()

      if data.getId() == null
        # Create new asset type
        api.callURL 'post', 'asset/type', obj
      else
        # Edit existing asset type
        api.callURL 'put', 'asset/type/' + data.getId(), obj



    saveOrganization: (data) ->

      obj =
        name: data.getName()
        ownerId: data.getOwnerId()
        contributors: data.getContributors()
        favourite: data.getFavourite()

      if data.getId() == null
        # Create new organization
        api.callURL 'post', 'organization', obj
      else
        # Edit existing organization
        api.callURL 'put', 'organization/' + data.getId(), obj



    toggleOrganizationFavourite: (organizationId) ->

      api.callURL 'post', 'organization/favourite',
        id: organizationId



    userProfile: ->

      api.callURL 'get', 'user'

  }
