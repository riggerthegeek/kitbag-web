'use strict'

describe 'Controller: AssetsCtrl', ->

  # load the controller's module
  beforeEach module 'kitbagApp'

  AssetsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AssetsCtrl = $controller 'AssetsCtrl', {
      $scope: scope
    }

  it.skip 'should attach a list of awesomeThings to the scope'
