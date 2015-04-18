'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:Organization
 # @description
 # # Organization
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'OrganizationModel', (lodash, Model, ValidationError) ->


  class Organization extends Model



    constructor: (data) ->

      super data

      @name = @_data.name || null
      @ownerId = @_data.ownerId || null
      @contributors = @_data.contributors || null
      @favourite = @setFavourite @_data.favourite



    canEdit: (userId) ->
      # @todo add in the contributors who can edit
      @ownerId == userId




    getContributors: ->
      @contributors



    getFavourite: ->
      @favourite



    getOwnerId: ->
      @ownerId



    getName: ->
      @name



    setFavourite: (favourite) ->
      if (lodash.isBoolean favourite)
        @favourite = favourite
      else
        @favourite = false



  Organization
