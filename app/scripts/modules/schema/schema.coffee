'use strict'

###*
 # @ngdoc service
 # @name kitbagApp.schema
 # @description
 # # schema
 # Factory in the kitbagApp.
###
angular.module 'kitbag.schema', []
.factory 'schema', ($http) ->

  schemaPrefix = '/scripts/schema/'
  schemaSuffix = '.json'

  loadSchema = (schema) ->
    url = schemaPrefix + schema + schemaSuffix

    $http.get url
      .then (res) ->
        res.data

  # Public API here
  {

    asset: ->
      loadSchema 'asset'

    assetType: ->
      loadSchema 'assettype'

    login: ->
      loadSchema 'login'

    organization: ->
      loadSchema 'organization'

  }
