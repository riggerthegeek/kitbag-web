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



    allAssetTypes: (organizationId) ->

      api.callURL 'get', 'asset/type?organizationId=' + organizationId



    getAssetType: (organizationId, assetTypeId) ->

      api.callURL 'get', 'asset/type/' + assetTypeId + '?organizationId=' + organizationId



    newOrganization: (data) ->

      api.callURL 'post', 'organization',
        name: data.name,
        favourite: data.favourite



    login: (emailAddress, password, rememberMe) ->

      defer = $q.defer()

      api.callURL 'post', 'system/web',
        emailAddress: emailAddress,
        password: password
      , false
        .then (data) ->

          # Success - store the sessionId
          authentication.setAuthKey data.sessionId, rememberMe

          defer.resolve()

        .catch (obj) ->

          # Failed - clear the sessionId
          authentication.clearAuthKey()

          status = if obj.status == 401 then 'UNAUTHORIZED' else 'UNKNOWN_ERR'

          defer.reject status

      defer.promise



    myOrganizations: ->

      api.callURL 'get', 'organization'



    organization: (organizationId) ->

      api.callURL 'get', 'organization/' + organizationId



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



    toggleOrganizationFavourite: (organizationId) ->

      api.callURL 'post', 'organization/favourite',
        id: organizationId



    userProfile: ->

      api.callURL 'get', 'user'

  }
