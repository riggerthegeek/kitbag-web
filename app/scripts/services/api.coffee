'use strict'

###*
 # @ngdoc service
 # @name kitbagApp.api
 # @description
 # # api
 # Provider in the kitbagApp.
###
angular.module 'kitbagApp'
.provider 'api', ->

  # Private variables
  baseUrl = ''



  # Private constructor
  class API



    constructor: (@q, @http, @lodash, @loginService, @authentication) ->



    callURL: (method, url, data, logoutOnError) ->

      logoutOnError = if logoutOnError == false then false else true

      self = @

      defer = self.q.defer()

      if typeof method is "string"
        method = method.toUpperCase()
      else
        throw TypeError 'Method must be a string'

      # Get the full URL
      url = self.getURL url

      options =
        method: method
        url: url
        headers:
          Accept: 'application/json'

      authKey = @authentication.getAuthKey()

      if authKey != null
        options.headers.authorization = authKey

      if method != 'GET'
        options.headers['Content-Type'] = 'application/json'
        if self.lodash.isObject(data) && self.lodash.isEmpty(data) == false
          options.data = data

      @http options
        .success (data, status, headers, config) ->
          # Successful call
          defer.resolve data, status, headers, config
        .error (data, status, headers, config) ->
          # Error - find the type
          if logoutOnError && status == 401
            # Unauthorized - logout from the API
            self.loginService.logout()
          else
            # Reject the promise
            defer.reject {
              data: data
              status: status
              headers: headers
              config: config
            }

      defer.promise



    getURL: (url) ->
      if typeof url != 'string'
        throw new TypeError 'apiProvider.getURL must be a string'

      endpoint = baseUrl + '/' + url

      # Remove duplicate slashes #
      endpoint = endpoint.replace /\/{2,}/g, '/'

      # Get rid of end slashes #
      endpoint = endpoint.replace /(\/+)$/, ''

      endpoint



  # Public API for configuration
  @setURL = (url) ->
    if typeof url != 'string' and url != null
      throw new TypeError 'apiProvider.setURL must be a string'

    baseUrl = url || ''



  # Method for instantiating
  @$get = ($q, $http, lodash, loginService, authentication) ->
    new API($q, $http, lodash, loginService, authentication)



  return
