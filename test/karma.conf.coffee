# Karma configuration
# http://karma-runner.github.io/0.12/config/configuration-file.html
# Generated on 2014-11-21 using
# generator-karma 0.8.3

module.exports = (config) ->
  configuration =

  # base path, that will be used to resolve files and exclude
    basePath: '../'

  # testing framework to use (jasmine/mocha/qunit/...)
    frameworks: [
      'mocha'
      'chai'
      'sinon'
      'sinon-chai'
    ]

  # list of files / patterns to load in the browser
    files: [
      'bower_components/angular/angular.js'
      'bower_components/angular-mocks/angular-mocks.js'
      'bower_components/angular-animate/angular-animate.js'
      'bower_components/angular-aria/angular-aria.js'
      'bower_components/angular-cookie/angular-cookie.js'
      'bower_components/angular-messages/angular-messages.js'
      'bower_components/angular-resource/angular-resource.js'
      'bower_components/angular-ui-router/release/angular-ui-router.js'
      'bower_components/angular-sanitize/angular-sanitize.js'
      'bower_components/angular-touch/angular-touch.js'
      'node_modules/sinon/pkg/sinon.js'
      'node_modules/chai/chai.js'
      'node_modules/sinon-chai/lib/sinon-chai.js'
      'node_modules/chai-as-promised/lib/chai-as-promised.js'
      'bower_components/tv4/tv4.js'
      'bower_components/objectpath/lib/ObjectPath.js'
      'bower_components/angular-schema-form/dist/schema-form.min.js'
      'bower_components/angular-schema-form/dist/bootstrap-decorator.min.js'
      'bower_components/ng-lodash/build/ng-lodash.js'
      'bower_components/angular-translate/angular-translate.js'
      'bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.js'
      'bower_components/angular-gravatar/build/md5.js'
      'bower_components/angular-gravatar/build/angular-gravatar.js'
      'bower_components/angular-bootstrap/ui-bootstrap-tpls.js'
      'bower_components/angular-ui-router.stateHelper/statehelper.js'
      'bower_components/angular-uuid4/angular-uuid4.js'
      'bower_components/ngprogress-lite/ngprogress-lite.js'
      'bower_components/modernizr/modernizr.js'
      'bower_components/modernizr/feature-detects/getusermedia.js'
      'bower_components/jsqrcode/src/grid.js'
      'bower_components/jsqrcode/src/version.js'
      'bower_components/jsqrcode/src/detector.js'
      'bower_components/jsqrcode/src/formatinf.js'
      'bower_components/jsqrcode/src/errorlevel.js'
      'bower_components/jsqrcode/src/bitmat.js'
      'bower_components/jsqrcode/src/datablock.js'
      'bower_components/jsqrcode/src/bmparser.js'
      'bower_components/jsqrcode/src/datamask.js'
      'bower_components/jsqrcode/src/rsdecoder.js'
      'bower_components/jsqrcode/src/gf256poly.js'
      'bower_components/jsqrcode/src/gf256.js'
      'bower_components/jsqrcode/src/decoder.js'
      'bower_components/jsqrcode/src/qrcode.js'
      'bower_components/jsqrcode/src/findpat.js'
      'bower_components/jsqrcode/src/alignpat.js'
      'bower_components/jsqrcode/src/databr.js'
      'bower_components/messageformat/messageformat.js'
      'bower_components/angular-translate-interpolation-messageformat/angular-translate-interpolation-messageformat.js'
      'bower_components/angular-utils-ui-breadcrumbs/uiBreadcrumbs.js'
      'bower_components/angular-snap/angular-snap.js'
      'bower_components/angular-schema-form-datepicker/bootstrap-datepicker.min.js'
      'app/scripts/**/*.coffee'
      'test/mock/**/*.coffee'
      'test/spec/**/*.coffee'
    ]

  # list of files / patterns to exclude
    exclude: []

  # web server port
    port: 8080

  # level of logging
  # possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO

  # Start these browsers, currently available:
  # - Chrome
  # - ChromeCanary
  # - Firefox
  # - Opera
  # - Safari (only Mac)
  # - PhantomJS
  # - IE (only Windows)
    browsers: [
      'PhantomJS'
      'Firefox'
    ]

    customLaunchers:
      'Chrome_travis_ci':
        base: 'Chrome'
        flags: [
          '--no-sandbox'
        ]


  # Which plugins to enable
    plugins: [
      'karma-phantomjs-launcher'
      'karma-firefox-launcher'
      'karma-chrome-launcher'
      'karma-mocha'
      'karma-chai'
      'karma-sinon'
      'karma-sinon-chai'
      'karma-coffee-preprocessor'
    ]

  # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

  # Continuous Integration mode
  # if true, it capture browsers, run tests and exit
    singleRun: false

    colors: true

    preprocessors:
      '**/*.coffee': ['coffee']

  if process.env.TRAVIS
    configuration.browsers.push 'Chrome_travis_ci'
  else
    configuration.browsers.push 'Chrome'

  config.set configuration

# Uncomment the following lines if you are using grunt's server to run the tests
# proxies: '/': 'http://localhost:9000/'
# URL root prevent conflicts with the site root
# urlRoot: '_karma_'
