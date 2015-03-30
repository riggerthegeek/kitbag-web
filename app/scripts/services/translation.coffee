'use strict'

###*
 # @ngdoc service
 # @name kitbagApp.translation
 # @description
 # # translation
 # Factory in the kitbagApp.
###
angular.module 'kitbagApp'
.factory 'translation', (lodash) ->

  # Service logic
  # ...
  mapWords = (replace, words) ->
    lodash.reduce replace, (result, value, key) ->
      if lodash.isObject value
        value = mapWords value, words
      else if lodash.isString value
        if lodash.has words, value
          value = words[value]

      result[key] = value

      result

    , {}

  # Public API here
  {
  mapWords: (replace, words) ->
    replace.map (obj) ->
      mapWords obj, words

  }
