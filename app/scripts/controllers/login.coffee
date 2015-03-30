'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:LoginCtrl
 # @description
 # # LoginCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'LoginCtrl', ($scope, schema, translate, engine, loginService, formError) ->

  validationMessages =
    emailAddress: {}
    password: {}

  # Add in variable keys
  validationMessages.emailAddress[tv4.errorCodes.STRING_PATTERN] = translate.ERROR_INVALID_EMAIL_PATTERN
  validationMessages.emailAddress[tv4.errorCodes.OBJECT_REQUIRED] = translate.ERROR_REQUIRED
  validationMessages.password[tv4.errorCodes.OBJECT_REQUIRED] = translate.ERROR_REQUIRED

  $scope.data = {}

  $scope.form = [
    key: 'emailAddress'
    title: null
    placeholder: translate.FORM_EMAIL_ADDRESS
    validationMessage: validationMessages.emailAddress
    addonPre: '<i class="fa fa-lg fa-user"></i>'
  ,
    key: 'password'
    title: null
    placeholder: translate.FORM_PASSWORD
    validationMessage: validationMessages.password
    addonPre: '<i class="fa fa-lg fa-lock"></i>'
    type: 'password'
  ,
    key: 'rememberMe'
    title: translate.FORM_REMEMBER_ME
    type: 'checkbox'
  ,
    type: 'submit'
    title: translate.SUBMIT_LOGIN
    style: 'btn-success btn-lg btn-block'
  ]

  # Get the schema
  $scope.schema = schema

  # Submit the form
  $scope.formSubmit = (form) ->

    $scope.$broadcast 'schemaFormValidate'

    if form.$valid

      # Attempt to login
      engine.login $scope.data.emailAddress, $scope.data.password, $scope.data.rememberMe
      .then ->
        loginService.getLoginRedirect()
      .catch (err) ->
        if (err == 'UNAUTHORIZED')
          message = 'ERROR_LOGIN_UNAUTHORIZED'
        else
          message = 'ERROR_LOGIN_UNKNOWN'

        formError.open message

  return
