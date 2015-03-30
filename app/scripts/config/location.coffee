'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.config
 # @description
 # # Location
 # Config of the kitbagApp
###
angular.module('kitbagApp')
.config ($locationProvider) ->
  ###
   HTML5 Configuration
  ###
  $locationProvider.html5Mode(
    enabled: true,
    requireBase: true,
    rewriteLinks: true
  )
