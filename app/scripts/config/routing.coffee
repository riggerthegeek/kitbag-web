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

  getOrganization = ($stateParams, engine, OrganizationModel) ->

    organizationId = $stateParams.organizationId

    if organizationId == null
      null
    else
      engine.organization (organizationId)
        .then (organization) ->
          OrganizationModel.toModel organization

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
    views:
      'beta@':
        templateUrl: 'views/controllers/betaRelease.html'
        controller: 'BetaReleaseCtrl'
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
          schema: (schema) ->

            schema.login()

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
        user: (engine, UserModel) ->

          engine.userProfile()
            .then (user) ->
              UserModel.toModel user

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

            engine.myOrganizations()
              .then (organizations) ->
                OrganizationsCollection.toCollection organizations

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
              pageTitle: 'BREADCRUMB_CREATE_ORGANIZATION'
            resolve:
              organization: ->
                null
              schema: (schema) ->

                schema.organization()

              translate: ($translate) ->

                translate = [
                  'ERROR_INVALID_EMAIL_PATTERN'
                  'ERROR_REQUIRED'
                  'FORM_ORGANIZATION_NAME'
                  'FORM_ORGANIZATION_FAVOURITE'
                  'ORGANIZATION_FAVOURITE_EXPLANATION'
                  'ORGANIZATION_NAME_EXPLANATION'
                  'ORGANIZATION_NAME_PLACEHOLDER'
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
              assetTypes: ($stateParams, engine, AssetTypesCollection) ->

                engine.allAssetTypes $stateParams.organizationId
                .then (assetTypes) ->
                  AssetTypesCollection.toCollection assetTypes

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
                  pageTitle: 'BREADCRUMB_CREATE_ASSET_TYPE'
                resolve:
                  assetType: ->
                    null

                  schema: (schema) ->

                    schema.assetType()

                  translate: ($translate) ->

                    translate = [
                      'FORM_MANUFACTURER'
                      'MANUFACTURER_EXPLANATION'
                      'FORM_MODEL'
                      'MODEL_EXPLANATION'
                      'FORM_MAINTENANCE_SCHEDULE'
                      'MAINTENANCE_SCHEDULE_EXPLANATION'
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
                  assets: ($stateParams, engine, AssetsCollection) ->

                    console.log AssetsCollection

                    engine.allAssets

                  assetType: ($stateParams, engine, AssetTypeModel) ->

                    engine.getAssetType $stateParams.organizationId, $stateParams.assetTypeId
                      .then (assetType) ->
                        AssetTypeModel.toModel assetType

                children: [
                  name: 'asset'
                  url: '/asset'
                  abstract: true
                  children: [
                    name: 'create'
                    url: '/create'
                    data:
                      pageTitle: 'BREADCRUMB_CREATE_ASSET'
                    resolve:
                      asset: ->
                        null

                      schema: (schema) ->

                        schema.asset()

                      translate: ($translate) ->

                        translate = [
                          'FORM_CURRENT_LOCATION'
                          'FORM_SERIAL_NUMBER'
                          'FORM_LAST_MAINTENANCE_DATE'
                          'FORM_PURCHASE_DATE'
                          'FORM_RETURN_REQUESTED'
                          'CURRENT_LOCATION_EXPLANATION'
                          'SERIAL_NUMBER_EXPLANATION'
                          'LAST_MAINTENANCE_DATE_EXPLANATION'
                          'PURCHASE_DATE_EXPLANATION'
                          'RETURN_REQUESTED_EXPLANATION'
                        ]

                        $translate translate

                    views:
                      'site@':
                        templateUrl: 'views/controllers/asset-edit.html'
                        controller: 'AssetEditCtrl'
                  ,
                    name: 'view'
                    url: '/:assetId'
                    data:
                      pageTitle: '{{ asset.getSerialNumber() }}'
                    resolve:
                      asset: ->
                        {
                          getSerialNumber: ->
                            'serial number'
                        }
                    views:
                      'site@':
                        templateUrl: 'views/controllers/asset.html'
                        controller: 'AssetCtrl'
                    children: [
                      name: 'edit'
                      url: '/edit'
                      data:
                        pageTitle: 'BREADCRUMB_EDIT_ASSET'
                      resolve:
                        asset: ->
                          222
                        schema: (schema) ->

                          schema.assetType()

                        translate: ($translate) ->

                          translate = [
                            'FORM_MANUFACTURER'
                            'MANUFACTURER_EXPLANATION'
                            'FORM_MODEL'
                            'MODEL_EXPLANATION'
                            'FORM_MAINTENANCE_SCHEDULE'
                            'MAINTENANCE_SCHEDULE_EXPLANATION'
                          ]

                          $translate translate
                      views:
                        'site@':
                          templateUrl: 'views/controllers/asset-edit.html'
                          controller: 'AssetEditCtrl'
                    ]
                  ]
                ,
                  name: 'edit'
                  url: '/edit'
                  views:
                    'site@':
                      templateUrl: 'views/controllers/asset-type-edit.html'
                      controller: 'AssetTypeEditCtrl'
                  data:
                    pageTitle: 'BREADCRUMB_EDIT_ASSET_TYPE'
                  resolve:
                    schema: (schema) ->

                      schema.assetType()

                    translate: ($translate) ->

                      translate = [
                        'FORM_MANUFACTURER'
                        'MANUFACTURER_EXPLANATION'
                        'FORM_MODEL'
                        'MODEL_EXPLANATION'
                        'FORM_MAINTENANCE_SCHEDULE'
                        'MAINTENANCE_SCHEDULE_EXPLANATION'
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
                pageTitle: 'BREADCRUMB_EDIT_ORGANIZATION'
              resolve:
                schema: (schema) ->

                  schema.organization()

                translate: ($translate) ->

                  translate = [
                    'ERROR_INVALID_EMAIL_PATTERN'
                    'ERROR_REQUIRED'
                    'FORM_ORGANIZATION_NAME'
                    'FORM_ORGANIZATION_FAVOURITE'
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
