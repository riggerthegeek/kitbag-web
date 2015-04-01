'use strict'

###*
 # @ngdoc directive
 # @name kitbagApp.directive:snap-menu
 # @description
 # # Snap Menu
###
angular.module 'kitbagApp'
.directive('kbSnapMenu', (lodash) ->

  controller: ($scope, snapRemote, snapMenuWidth) ->

    $scope.active = false

    $scope.displaySnap = lodash.isUndefined($scope.snap) == false

    $scope.snapOptions =
      disable: 'left'
      minPosition: -(snapMenuWidth)

    snapRemote.getSnapper()
      .then (snapper) ->

        snapper.on 'open', ->
          $scope.active = true

        snapper.on 'close', ->
          $scope.active = false

        return

  restrict: 'E'

  scope:
    snap: '='

  templateUrl: 'views/directives/snapMenu.html'

  transclude: true

)
