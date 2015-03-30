'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:Organizations
 # @description
 # # Organizations
 # Collections of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'OrganizationsCollection', (Collection, OrganizationModel, lodash) ->



  class Organizations extends Collection


    constructor: (data) ->

      @_model = OrganizationModel

      super data


    getFavourites: ->

      @reduce (collection, model) ->

        if model.getFavourite()
          collection.push model

        collection


    getOrdinary: ->

      @reduce (collection, model) ->

        if !model.getFavourite()
          collection.push model

        collection



    sort: ->

      super (a, b) ->

        # Sort by favourites
        if a.getFavourite() > b.getFavourite()
          # a is true, b is false
          -1
        else if a.getFavourite() < b.getFavourite()
          # a is false, b is true
          1
        else
          # Both share the favourite status - do by name now
          if a.getName() < b.getName()
            -1
          else if a.getName() > b.getName()
            1
          else
            0



  Organizations
