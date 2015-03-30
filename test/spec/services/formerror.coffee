'use strict'

describe 'Service: formError', ->

  # load the service's module
  beforeEach module 'kitbagApp'

  # instantiate service
  formError = {}
  beforeEach inject (_formError_) ->
    formError = _formError_

  it 'should do something', ->
    expect(!!formError).to.be.true
