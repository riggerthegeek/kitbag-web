'use strict'

###
  This controls the displaying of the beta release
  bar at the bottom of the screen.  There are two
  distinct states
    1: If it's not a beta release, nothing is shown
    ever.

    2: If it is a beta release, the default is to
    show the bar at the bottom.  However, this can
    be hidden, just leaving the "report a bug" icon
    as a helper.  Once it's hidden, it is stored in
    a cookie and the bar isn't shown again.
###
angular.module 'kitbagApp'
  .controller 'BetaReleaseCtrl', ($scope, ENV) ->

    $scope.betaRelease = ENV.betaRelease
    $scope.version = ENV.version
