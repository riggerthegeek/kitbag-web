'use strict'

describe 'Service: translation', ->

  # load the service's module
  beforeEach module 'kitbagApp'

  # instantiate service
  translation = {}
  beforeEach inject (_translation_) ->
    translation = _translation_

  it 'should do something', ->
    expect(!!translation).to.be.true
