'use strict'

###*
 # @ngdoc directive
 # @name kitbagApp.directive:organization
 # @description
 # # organization
###
angular.module 'kitbagApp'
.directive('kbConfirmClick', ->

  link: (scope, element, attrs) ->

    element.bind 'click', (e) ->

      message = attrs.kbConfirmClick

      if(message && !confirm(message))

        e.stopImmediatePropagation()
        e.preventDefault()

  priority: -1

  restrict: 'A'

)
