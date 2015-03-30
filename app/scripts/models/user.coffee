'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:User
 # @description
 # # User
 # Model of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'UserModel', (Model) ->


  class User extends Model



    constructor: (data) ->

      super data

      @username = @_data.username || null
      @password = @_data.password || null
      @firstName = @_data.firstName || null
      @lastName = @_data.lastName || null
      @emailAddress = @_data.emailAddress || null
      @permissions = @_data.permissions || null


    getEmailAddress: ->
      @emailAddress


    getFullName: ->
      if @firstName != null && @lastName != null
        @firstName + ' ' + @lastName
      else
        null



  User
