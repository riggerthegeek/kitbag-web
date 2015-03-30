'use strict'

describe 'Service: api', ->

  # load the service's module
  beforeEach module 'kitbagApp'

  # instantiate service
  api = {}
  beforeEach ->
    angular.module 'dummyModule', []
    .config [
      'apiProvider'
      (_apiProvider_) ->
        api = _apiProvider_
    ]

    module 'kitbagApp', 'dummyModule'

    inject () ->

  describe 'configuration', ->
    it 'should throw error when non-string added', ->
      fail = false

      try
        api.setURL {}
      catch err
        fail = true

        expect(err).to.be.instanceof TypeError
        expect(err.message).to.be.equal 'apiProvider.setURL must be a string'

      finally
        expect(fail).to.be.true

  describe 'Methods', ->
    describe '#getURL', ->
      it 'should get the full URL', ->
        api.setURL '/test/'

        obj = api.$get()

        expect(obj.getURL 'hello/world').to.be.equal '/test/hello/world'

      it 'should get rid of additional slashes', ->
        api.setURL '/api/'

        obj = api.$get()

        expect(obj.getURL '/some/url/').to.be.equal '/api/some/url'
        expect(obj.getURL '/some///otherurl//').to.be.equal '/api/some/otherurl'

      it 'should allow no base URL to be set', ->
        api.setURL(null)

        obj = api.$get()

        expect(obj.getURL 'some/url').to.be.equal '/some/url'

      it 'should throw error when non-string passed in', ->
        fail = false

        api.setURL '/test/'

        obj = api.$get()

        try
          obj.getURL {}
        catch err
          fail = true

          expect(err).to.be.instanceof TypeError
          expect(err.message).to.be.equal 'apiProvider.getURL must be a string'

        finally
          expect(fail).to.be.true
