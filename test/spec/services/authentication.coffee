'use strict'

describe 'Service: authentication', ->
  ipCookie = null
  rememberLoginDays = null

  beforeEach module 'kitbagApp' # (or just 'myApp.services')

  beforeEach ->
    angular.mock.module ($provide) ->
      ipCookie = sinon.stub()
      ipCookie.remove = sinon.stub()

      rememberLoginDays = 21

      $provide.value 'ipCookie', ipCookie
      $provide.value 'rememberLoginDays', rememberLoginDays
      null

  authentication = null
  beforeEach inject ($injector) ->
    authentication = $injector.get 'authentication'

  describe 'Methods', ->
    describe '#clearAuthKey', ->
      it 'should clear the auth key', ->
        authentication.clearAuthKey()

        ipCookie.remove.should.be.calledOnce
          .calledWithExactly 'userAuthKey',
            domain: undefined
            expires: undefined
            expirationUnit: undefined
            path: '/'
            secure: false

    describe '#getAuthKey', ->
      it 'should return null when no cookie set', ->
        expect(authentication.getAuthKey()).to.be.null

      it 'should return the cookie value when set', ->
        ipCookie.returns '12345'

        expect(authentication.getAuthKey()).to.be.equal '12345'

        ipCookie.should.have.been.calledOnce
        .calledWith 'userAuthKey'

    describe '#setAuthKey', ->
      it 'should set an auth key', ->
        authentication.setAuthKey '2356'

        ipCookie.should.have.been.calledOnce
          .calledWithExactly 'userAuthKey', '2356',
            domain: undefined
            expirationUnit: undefined
            expires: undefined
            path: '/'
            secure: false

      it 'should remember the cookie past this session', ->
        authentication.setAuthKey 'key', true

        ipCookie.should.have.been.calledOnce
          .calledWithExactly 'userAuthKey', 'key',
            domain: undefined
            expirationUnit: undefined
            expires: 21
            path: '/'
            secure: false

      it 'should clear the authKey on empty string', ->
        authentication.setAuthKey ''

        ipCookie.should.not.have.been.called

        ipCookie.remove.should.have.been.calledOnce

      it 'should clear the authKey on a non-string', ->
        [
          ->
          2.3
          true
          false
          null
          []
          {}
        ].forEach (input, i) ->
          authentication.setAuthKey input

          ipCookie.should.not.have.been.called

          ipCookie.remove.should.have.been.callCount i + 1
