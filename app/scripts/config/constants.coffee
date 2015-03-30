'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.config
 # @description
 # # Constants
 # Config of the kitbagApp
###
angular.module('kitbagApp')
.value 'cookieNames',
  acceptCookieMessage: 'acceptCookieMessage'
  loginRedirect: 'loginRedirect'
  loginRedirectParams: 'loginRedirectParams'
  userAuthKey: 'userAuthKey'

.value 'rememberLoginDays', 14

.value 'snapMenuWidth', 300
