'use strict'

###*
 # @ngdoc service
 # @name kitbagApp.authentication
 # @description
 # # authentication
 # Factory in the kitbagApp.
###
angular.module 'kitbagApp'
.factory 'authentication', (cookies, rememberLoginDays, cookieNames) ->

  # Service logic
  cookieName = cookieNames.userAuthKey

  # Public API here

  {

    clearAuthKey: ->
      cookies.destroy cookieName

    getAuthKey: ->
      value = cookies.get cookieName

      if !value
        value = null

      value

    setAuthKey: (auth, remember) ->
      if typeof auth != 'string' or auth == ''
        @clearAuthKey()
      else
        options = {}

        if remember
          options.expires = rememberLoginDays

        cookies.set cookieName, auth, options

  }
