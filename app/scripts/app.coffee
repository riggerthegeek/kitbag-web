'use strict'

###*
 # @ngdoc overview
 # @name kitbagApp
 # @description
 # # kitbagApp
 #
 # Main module of the application.
###
angular
.module 'kitbagApp', [
  'kitbag.schema'
  'ngAnimate'
  'ngAria'
  'ipCookie'
  'ngMessages'
  'ngResource'
  'ui.router'
  'ngSanitize'
  'ngTouch'
  'ngLodash'
  'schemaForm'
  'pascalprecht.translate'
  'ui.gravatar'
  'ui.bootstrap'
  'ui.router.stateHelper'
  'uuid4'
  'ngProgressLite'
  'angularUtils.directives.uiBreadcrumbs'
  'snap'
]

.run ($rootScope, $state, loginService, ngProgressLite) ->

  # Handle state change error
  $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->

    event.preventDefault()

    $state.get('error').err = error

    $state.go 'error'

  $rootScope.$on '$stateChangeStart', (event, toState, toParams) ->

    # Ensure that pages that require a login actually have logged in
    requireLogin = if toState.data && toState.data.requireLogin == true then true else false

    if requireLogin && loginService.isLoggedIn() == false
      loginService.checkLoggedIn(toState.name, toParams)

      event.preventDefault()

      return

  # Start a page loading progress bar
  $rootScope.$on '$viewContentLoading', ->

    ngProgressLite.start()

  # Page load - end the bar
  $rootScope.$on '$viewContentLoaded', ->

    ngProgressLite.done()
