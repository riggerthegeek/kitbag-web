'use strict'

describe 'Controller: OrganizationsCtrl', ->

  # load the controller's module
  beforeEach module 'kitbagApp'

  OrganizationsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    OrganizationsCtrl = $controller 'OrganizationsCtrl', {
      $scope: scope
    }

  it.skip 'should attach a list of awesomeThings to the scope'
