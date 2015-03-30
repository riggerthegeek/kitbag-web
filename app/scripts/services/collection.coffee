'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:Collection
 # @description
 # # Collection
 # Factory of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'Collection', (lodash, uuid4) ->


  class Collection



    constructor: (data) ->

      # Array of models stored here
      @_data = []

      # Object mapping GUID to array keys
      @_hash = {}

      @reset()

      # Ensure the model is set
      if !@_model && angular.isFunction @_model
        throw new SyntaxError 'The data model must be specified and have a constructor function'

      # Activate the addAll method
      @addAll data

      @sort()





    add: (model) ->

      if angular.isObject model

        # Create as a model instance
        obj = new @_model model

        # Store the model as a hash
        @_hash[uuid4.generate()] = obj

        # Store the data
        @_data.push obj



    addAll: (models) ->

      if angular.isArray(models) and models.length > 0

        @add model for model in models



    get: (key) ->

      # Return null when can't find anything
      model = null

      if lodash.isNumber key

        # Number: search by array key
        if lodash.has @_data, key
          model = @_data[key]

      else if lodash.isString key

        # String: search by hash
        if lodash.has @_hash, key
          # Get the ID and rerun
          model = @get @_hash[key]

      else if lodash.isObject key

        # Object: compare with model instance
        obj = lodash.find @_data, key

        if obj
          model = obj

      # Return the found model
      model


    each: (fn) ->

      lodash.each @getAll(), fn, @


    getAll: ->
      @_data


    reduce: (fn) ->

      lodash.reduce @getAll(), fn, [], @



    remove: (key) ->

      if angular.isNumber key
        # Delete by key
      else
        # Delete by object comparison



    reset: ->
      @_data = []
      @_hash = {}



    size: ->
      @_data.length



    sort: (sortOrder) ->

      @_data.sort sortOrder


    ###
      To JSON

      Returns a plain JSON object of the data
    ###
    toJSON: ->
      json = []

      json.push model.toObject for model in @getAll()

      json



      ###
        Static Methods
      ###
    @toCollection = (data) ->

      new this data



  Collection
