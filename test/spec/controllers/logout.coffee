'use strict'

describe 'Controller: LogoutCtrl', ->

  # load the controller's module
  beforeEach module 'kitbagApp'

  LogoutCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    LogoutCtrl = $controller 'LogoutCtrl', {
      $scope: scope
    }

  it.skip 'should attach a list of awesomeThings to the scope'
