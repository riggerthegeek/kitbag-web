'use strict'

describe 'Controller: FooterCtrl', ->

  # load the controller's module
  beforeEach module 'kitbagApp'

  FooterCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FooterCtrl = $controller 'FooterCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).to.be.equal 3
