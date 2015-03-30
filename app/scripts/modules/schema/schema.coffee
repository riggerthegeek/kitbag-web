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

  # Public API here
  {

    assetType: ->
      loadSchema 'assettype'

    login: ->
      loadSchema 'login'

    organization: ->
      loadSchema 'organization'

  }
