'use strict'

describe 'Directive: layout', ->

  # load the directive's module
  beforeEach module 'kitbagApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<layout></layout>'
    element = $compile(element) scope
    expect(element.text()).to.be.equal ''
