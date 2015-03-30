'use strict'

describe 'Controller: FormerrorCtrl', ->

  # load the controller's module
  beforeEach module 'kitbagApp'

  FormerrorCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FormerrorCtrl = $controller 'FormerrorCtrl', {
      $scope: scope
    }

  it.skip 'should attach a list of awesomeThings to the scope'
