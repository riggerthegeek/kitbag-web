'use strict'

###*
 # @ngdoc service
 # @name kitbagApp.cookies
 # @description
 # # cookies
 # Factory in the kitbagApp.
###
angular.module 'kitbagApp'
  .factory 'cookies', (ipCookie, lodash) ->

    cookieOpts = (options) ->

      options = if lodash.isObject(options) then options else {}

      {
        domain: options.domain || undefined
        expires: options.expires || undefined
        expirationUnit: options.expirationUnit || undefined
        path: options.path || '/'
        secure: options.secure || false
      }

    {

      destroy: (key, options) ->

        ipCookie.remove key, cookieOpts(options)

      get: (key) ->
        ipCookie key

      set: (key, value, options) ->

        ipCookie key, value, cookieOpts(options)

    }
