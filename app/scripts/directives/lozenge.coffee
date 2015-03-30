'use strict'

###*
 # @ngdoc directive
 # @name kitbagApp.directive:organization
 # @description
 # # organization
###
angular.module 'kitbagApp'
.directive('kblozenge', ->

  link: (scope, element, attrs) ->

    boxStyle = attrs.boxStyle || 'default'

    scope.boxStyle = ('lozenge-') + boxStyle


  restrict: 'E'

  scope:
    href: '@'
    hrefVars: '='

  templateUrl: 'views/directives/lozenge.html'

  transclude: true

)
