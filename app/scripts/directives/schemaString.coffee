'use strict'

###*
 # @ngdoc directive
 # @name kitbagApp.directive:schema-string
 # @description
 # # Takes the schema data and converts it into an
  appropriate string
###
angular.module 'kitbagApp'
.directive('kbSchemaString', ($filter, lodash, $locale) ->

  restrict: 'E'

#  controller: ($scope) ->
#
#    console.log($scope.schema)
#    console.log($scope.data);


  link: (scope, element, attrs) ->

    # Decide how to display the data
    if lodash.isNull(scope.data) || lodash.isUndefined(scope.data)
      # Empty data
      if lodash.has(scope.schema, 'default')
        scope.data = scope.schema.default


  scope:
    data: '='
    schema: '='

  templateUrl: 'views/directives/schemaString.html'

  transclude: true

)
