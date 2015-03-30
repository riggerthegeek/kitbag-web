'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.config
 # @description
 # # loginService
 # Config of the kitbagApp
###
angular.module('kitbagApp')
.config (loginServiceProvider) ->
  ###
   Failed/default login config
  ###
  loginServiceProvider.setDefaultLoginPage 'kitbag.private.organizations'
  loginServiceProvider.setFallbackState 'kitbag.public.login'
