'use strict'

describe 'Controller: HomeCtrl', ->

  # load the controller's module
  beforeEach module 'kitbagApp'

  MainCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller 'HomeCtrl', {
      $scope: scope
    }

  it.skip 'should attach a list of awesomeThings to the scope'
