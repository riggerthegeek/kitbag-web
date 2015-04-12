'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.directive:kbActionMenu
 # @description
 # # Action Menu directive
###
angular.module('kitbagApp')
.directive 'kbActionMenu', ->


  restrict: 'E'


  replace: true


  scope:
    form: '='
    items: '='


  templateUrl: 'views/directives/actionMenu.html'
