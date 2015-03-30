'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.config
 # @description
 # # API
 # Config of the kitbagApp
###
angular.module('kitbagApp')
.config (apiProvider) ->
  ###
   Set the API URL
  ###
  apiProvider.setURL '/api/'
