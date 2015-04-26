'use strict'

###*
 # @ngdoc service
 # @name kitbagApp.loginService
 # @description
 # # loginService
 # Provider in the kitbagApp.
###
angular.module 'kitbagApp'
.provider 'loginService', ->

  # Private variables
  defaultLoginPage = null

  fallbackState = null

  ignoreStates = []

  # Private constructor
  class Login



    constructor: (@q, @state, @stateParams, @authentication, @cookies, @lodash, cookieNames) ->
      @loginRedirectCookie = cookieNames.loginRedirect
      @loginRedirectParams = cookieNames.loginRedirectParams



    checkLoggedIn: (currentState, currentParams) ->
      if @isLoggedIn() == false

        if ignoreStates.indexOf(currentState) == -1
          # Not logged in - save current state in case we log in
          @cookies.set @loginRedirectCookie, currentState
          @cookies.set @loginRedirectParams, currentParams

        # Now, send to the fallback state
        @state.go fallbackState



    getLoginRedirect: ->
      redirect = @cookies.get @loginRedirectCookie
      redirectParams = @cookies.get @loginRedirectParams

      if !@lodash.isObject redirectParams
        redirectParams = {}

      if !redirect
        # No redirect state - go to default
        redirect = defaultLoginPage

      # No, send to the login state
      @state.go redirect, redirectParams



    isLoggedIn: ->
      @authentication.getAuthKey() != null



    logout: (redirectState) ->

      @authentication.clearAuthKey()

      if !redirectState
        # Reload page
        @state.reload()
      else if redirectState == true
        # Go to default page
        console.log(@state.go defaultLoginPage)
      else
        # Go to specified page
        @state.go redirectState



  # Public API for configuration



  ###*
   # Set Default Login Page
   #
   # State to go to when logging in and no
   # private state previously attempted
  ###
  @setDefaultLoginPage = (state) ->
    defaultLoginPage = state



  ###*
   # Set Fallback State
   #
   # State to fallback to if we're not logged in
  ###
  @setFallbackState = (state) ->
    fallbackState = state



  ###*
   # Set Ignore States
   #
   # Sets the states we ignore when saving the pages
  ###
  @setIgnoreStates = (states) ->
    ignoreStates = states



  # Method for instantiating
  @$get = ($q, $state, $stateParams, authentication, cookies, lodash, cookieNames) ->
    if defaultLoginPage == null
      throw new Error 'loginService.defaultLoginPage must be set'

    if fallbackState == null
      throw new Error 'loginService.fallbackState must be set'

    new Login($q, $state, $stateParams, authentication, cookies, lodash, cookieNames)



  return
