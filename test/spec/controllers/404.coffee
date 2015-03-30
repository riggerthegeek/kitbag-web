'use strict'

describe 'Controller: Err404Ctrl', ->

  # load the controller's module
  beforeEach module 'kitbagApp'

  Err404Ctrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    Err404Ctrl = $controller 'Err404Ctrl', {
      $scope: scope
    }

  it.skip 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).to.be.equal 3
