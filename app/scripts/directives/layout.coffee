'use strict'

###*
 # @ngdoc directive
 # @name kitbagApp.directive:layout
 # @description
 # # layout
###
angular.module 'kitbagApp'
.directive('kblayout', ->
  restrict: 'E'
  scope: true
  templateUrl: (element, attrs) ->
    template = attrs.template || 'dashboard'
    'views/layouts/' + template + '.html'
  transclude: true
)
