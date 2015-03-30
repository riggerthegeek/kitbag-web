'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.config
 # @description
 # # Translate
 # Config of the kitbagApp
###
angular.module('kitbagApp')
.config ($translateProvider) ->
  ###
   I18N config
  ###
  $translateProvider
  .useStaticFilesLoader
    prefix: 'scripts/i18n/locale-'
    suffix: '.json'
  .registerAvailableLanguageKeys [
      'en_GB'
      'en'
    ],
    'en_US': 'en'
  .determinePreferredLanguage()
  .fallbackLanguage 'en'
  .addInterpolation '$translateMessageFormatInterpolation'
