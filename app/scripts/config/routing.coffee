'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.config
 # @description
 # # Routing
 # Config of the kitbagApp
###
angular.module('kitbagApp')
.config (stateHelperProvider, $urlRouterProvider) ->

  getOrganization = ($q, $stateParams, engine, OrganizationModel) ->

    organizationId = $stateParams.organizationId

    if organizationId == null
      null
    else
      defer = $q.defer()

      engine.organization (organizationId)
      .then (organization) ->
        defer.resolve OrganizationModel.toModel organization
      .catch (err) ->
        defer.reject err

      defer.promise

  todoTemplate = '<kblayout><kb-breadcrumbs></kb-breadcrumbs>@todo: {{ name }}</kblayout>'
  todoController = ($scope, $state, user) ->
    $scope.name = $state.current.name

    $scope.user = user

  ###
   Routing
  ###
  stateHelperProvider.setNestedState
    name: 'kitbag'
    abstract: true
    url: '/'
    resolve:
      user: ->
        null
    children: [
      name: 'public'
      abstract: true
      children: [
        name: 'login'
        url: 'login'
        views:
          'site@':
            templateUrl: 'views/controllers/login.html'
            controller: 'LoginCtrl'
        resolve:
          schema: ($q, schema) ->

            defer = $q.defer()

            schema.login()
            .then (obj) ->
              defer.resolve obj.data
            .catch (err) ->
              defer.reject err

            defer.promise

          translate: ($translate) ->

            translate = [
              'ERROR_INVALID_EMAIL_PATTERN'
              'ERROR_REQUIRED'
              'FORM_EMAIL_ADDRESS'
              'FORM_PASSWORD'
              'FORM_REMEMBER_ME'
              'SUBMIT_LOGIN'
            ]

            $translate translate
      ,
        name: 'search'
        url: 'search'
        views:
          'site@':
            template: todoTemplate
            controller: todoController
        data:
          pageTitle: 'SEARCH_PAGETITLE'
      ,
        name: '404'
        url: '404'
        views:
          'site@':
            templateUrl: 'views/controllers/404.html'
            controller: 'Err404Ctrl'
      ]
    ,
      name: 'private'
      abstract: true
      data:
        requireLogin: true
      resolve:
        user: ($q, engine, UserModel) ->

          defer = $q.defer()

          engine.userProfile()
          .then (user) ->
            defer.resolve UserModel.toModel user
          .catch (err) ->
            defer.reject err

          defer.promise
      children: [
        name: 'barcode_scanner'
        url: 'scanner'
        views:
          'site@':
            templateUrl: 'views/controllers/barcode_scanner.html'
            controller: 'BarcodeScannerCtrl'
        data:
          pageTitle: 'SCANNER_PAGETITLE'
      ,
        name: 'logout'
        url: 'logout'
        resolve:
          logout: (loginService) ->

            loginService.logout true
      ,
        name: 'organizations'
        url: ''
        views:
          'site@':
            templateUrl: 'views/controllers/organizations.html'
            controller: 'OrganizationsCtrl'
        data:
          pageTitle: 'ORGANIZATIONS_PAGETITLE'
        resolve:
          organizations: ($q, engine, OrganizationsCollection) ->
            defer = $q.defer()

            engine.myOrganizations()
            .then (organizations) ->
              defer.resolve OrganizationsCollection.toCollection organizations
            .catch (err) ->
              defer.reject err

            defer.promise
        children: [
          name: 'organization'
          url: 'org'
          abstract: true
          children: [
            name: 'create'
            url: '/create'
            views:
              'site@':
                templateUrl: 'views/controllers/organization-edit.html'
                controller: 'OrganizationEditCtrl'
            data:
              pageTitle: 'BREADCRUMB_CREATE'
            resolve:
              organization: ->
                null
              schema: ($q, schema) ->
                defer = $q.defer()

                schema.organization()
                .then (obj) ->
                  defer.resolve obj.data
                .catch (err) ->
                  defer.reject err

                defer.promise
              translate: ($translate) ->

                translate = [
                  'ERROR_INVALID_EMAIL_PATTERN'
                  'ERROR_REQUIRED'
                  'FORM_ORGANIZATION_NAME'
                  'FORM_ORGANIZATION_FAVOURITE'
                  'SUBMIT_CREATE'
                  'SUBMIT_SAVE'
                ]

                $translate translate
          ,
            name: 'view'
            url: '/:organizationId'
            views:
              'site@':
                templateUrl: 'views/controllers/organization.html'
                controller: 'OrganizationCtrl'
            data:
              pageTitle: '{{ organization.getName() }}'
            resolve:
              assetTypes: ($q, $stateParams, engine, AssetTypesCollection) ->
                defer = $q.defer()

                engine.allAssetTypes $stateParams.organizationId
                .then (assetTypes) ->
                  defer.resolve AssetTypesCollection.toCollection assetTypes
                .catch (err) ->
                  defer.reject err

                defer.promise
              organization: getOrganization
            children: [
              name: 'asset-type'
              url: '/type'
              abstract: true
              children: [
                name: 'create'
                url: '/create'
                views:
                  'site@':
                    templateUrl: 'views/controllers/asset-type-edit.html'
                    controller: 'AssetTypeEditCtrl'
                data:
                  pageTitle: 'BREADCRUMB_CREATE'
                resolve:
                  assetType: ->
                    null

                  schema: ($q, schema) ->

                    defer = $q.defer()

                    schema.assetType()
                    .then (obj) ->
                      defer.resolve obj.data
                    .catch (err) ->
                      defer.reject err

                    defer.promise

                  translate: ($translate) ->

                    translate = [
                      'FORM_MANUFACTURER'
                      'MANUFACTURER_EXPLANATION'
                      'FORM_MODEL'
                      'MODEL_EXPLANATION'
                      'FORM_MAINTENANCE_SCHEDULE'
                      'MAINTENANCE_SCHEDULE_EXPLANATION'
                      'SUBMIT_CREATE'
                      'SUBMIT_SAVE'
                    ]

                    $translate translate
              ,
                name: 'view'
                url: '/:assetTypeId'
                views:
                  'site@':
                    templateUrl: 'views/controllers/asset-type.html'
                    controller: 'AssetTypeCtrl'
                data:
                  pageTitle: '{{ assetType.getName() }}'
                resolve:
                  assetType: ($q, $stateParams, engine, AssetTypeModel) ->
                    defer = $q.defer()

                    engine.getAssetType $stateParams.organizationId, $stateParams.assetTypeId
                    .then (assetType) ->
                      defer.resolve AssetTypeModel.toModel assetType
                    .catch (err) ->
                      defer.reject err

                    defer.promise
                children: [
                  name: 'edit'
                  url: '/edit'
                  views:
                    'site@':
                      templateUrl: 'views/controllers/asset-type-edit.html'
                      controller: 'AssetTypeEditCtrl'
                  data:
                    pageTitle: 'BREADCRUMB_EDIT'
                  resolve:
                    schema: ($q, schema) ->

                      defer = $q.defer()

                      schema.assetType()
                      .then (obj) ->
                        defer.resolve obj.data
                      .catch (err) ->
                        defer.reject err

                      defer.promise

                    translate: ($translate) ->

                      translate = [
                        'FORM_MANUFACTURER'
                        'MANUFACTURER_EXPLANATION'
                        'FORM_MODEL'
                        'MODEL_EXPLANATION'
                        'FORM_MAINTENANCE_SCHEDULE'
                        'MAINTENANCE_SCHEDULE_EXPLANATION'
                        'SUBMIT_CREATE'
                        'SUBMIT_SAVE'
                      ]

                      $translate translate
                ]
              ]
            ,
              name: 'edit'
              url: '/edit'
              views:
                'site@':
                  templateUrl: 'views/controllers/organization-edit.html'
                  controller: 'OrganizationEditCtrl'
              data:
                pageTitle: 'BREADCRUMB_EDIT'
              resolve:
                schema: ($q, schema) ->
                  defer = $q.defer()

                  schema.organization()
                  .then (obj) ->
                    defer.resolve obj.data
                  .catch (err) ->
                    defer.reject err

                  defer.promise
                translate: ($translate) ->

                  translate = [
                    'ERROR_INVALID_EMAIL_PATTERN'
                    'ERROR_REQUIRED'
                    'FORM_ORGANIZATION_NAME'
                    'FORM_ORGANIZATION_FAVOURITE'
                    'SUBMIT_SAVE'
                  ]

                  $translate translate
            ]
          ]
        ]
      ,
        name: 'settings'
        url: 'settings'
        data:
          pageTitle: 'SETTINGS_PAGETITLE'
        views:
          'site@':
            template: todoTemplate
            controller: todoController
      ]
    ]
  .setNestedState
    name: 'error'
    views:
      'site@':
        templateUrl: 'views/controllers/error.html'
        controller: 'ErrorCtrl'

  $urlRouterProvider.otherwise '/404'
