'use strict'

describe 'Service: engine', ->

  # load the service's module
  beforeEach module 'kitbagApp'

  # instantiate service
  engine = {}
  beforeEach inject (_engine_) ->
    engine = _engine_


  describe 'Methods', ->
    describe '#login', ->
      it.skip 'should login'
