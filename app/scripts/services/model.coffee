'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:Model
 # @description
 # # Model
 # Factory of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'Model', (lodash) ->


  class Model


    ###*
      Constructor

      Default constructor for the Model.  Should
      always call this method
    ###
    constructor: (data) ->

      @_data = {}

      if lodash.isObject(data) == false
        data = {}

      # Set the input data to the model
      @_data = data

      # Common methods
      @id = null
      @created = null
      @updated = null

      if @_data.id
        @setId @_data.id

      if @_data.created
        @setCreated @_data.created

      if @_data.updated
        @setUpdated @_data.updated


    getId: ->
      @id


    getCreated: ->
      @created


    getUpdated: ->
      @updated


    setCreated: (datetime) ->
      @created = Model.setDate datetime
      @


    setId: (id) ->
      @id = Model.setString id, null
      @


    setUpdated: (datetime) ->
      @updated = Model.setDate datetime
      @


    toObject: ->
      data = lodash.clone @
      lodash.reduce data, (result, value, key) ->
        if !key.match /^\_/
          result[key] = value
        result
      , {}


    validate: ->
      true




    ###
      Static Methods
    ###
    @setBool = (value, def) ->
      if lodash.isBoolean value
        value
      else if value == 'Y' || value == 1 || value == '1'
        true
      else if value == 'N' || value == 0 || value == '0'
        false
      else
        def

    @setDate = (value, def) ->
      if value
        if lodash.isDate value
          value
        else
          new Date value
      else
        def


    @setString = (value, def) ->
      if lodash.isString value
        value
      else
        def



    @toModel = (data) ->

      new this data



  Model
