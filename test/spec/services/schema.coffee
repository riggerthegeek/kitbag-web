'use strict'

describe 'Service: schema', ->

  # load the service's module
  beforeEach module 'kitbag.schema'

  # instantiate service
  schemaFactory = {}
  $httpBackend = {}
  beforeEach inject (schema, _$httpBackend_) ->
    schemaFactory = schema
    $httpBackend = _$httpBackend_

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe 'Methods', ->
    describe '#login', ->
      it 'should load the login schema', ->
        $httpBackend.whenGET '/scripts/schema/login.json'
        .respond 200,
          howdy: 'partner'

        schemaFactory.login()
        .then (obj) ->
          expect(obj.data).to.be.eql
            howdy: 'partner'

        $httpBackend.expectGET '/scripts/schema/login.json',
          Accept: 'application/json, text/plain, */*'

        $httpBackend.flush();

      it 'should handle a login schema error', ->
        $httpBackend.whenGET '/scripts/schema/login.json'
        .respond 500,
          howdy: 'partner'

        schemaFactory.login()
        .catch (obj) ->
          expect(obj.status).to.be.equal 500

        $httpBackend.expectGET '/scripts/schema/login.json',
          Accept: 'application/json, text/plain, */*'

        $httpBackend.flush()
