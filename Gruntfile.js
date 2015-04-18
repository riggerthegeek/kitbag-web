// Generated on 2014-11-21 using generator-angular 0.10.0
'use strict';

// Fix for the html5mode bug in Angular
// @link http://www.marushkevych.com/2014/03/26/angular-html5mode-refresh

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/**/*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

var fs = require('fs-extra');

module.exports = function (grunt) {

  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  // Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt);

  // Configurable paths for the application
  var appConfig = {
    app: require('./bower.json').appPath || 'app',
    constants: null,
    dist: 'dist',
    test: 'test'
  };

  appConfig.constants = appConfig.app + '/scripts/config/envvars.coffee';

  var pkg = require('./package');

  var modRewrite = require('connect-modrewrite');
  var mountFolder = function (connect, dir) {
    return connect.static(require('path').resolve(dir));
  };

  // Define the configuration for all the tasks
  grunt.initConfig({

    // Project settings
    yeoman: appConfig,

    // NPM Package
    pkg: pkg,

    // Watches files for changes and runs tasks based on the changed files
    watch: {
      bower: {
        files: ['bower.json'],
        tasks: ['wiredep']
      },
      coffee: {
        files: ['<%= yeoman.app %>/scripts/**/*.{coffee,litcoffee,coffee.md}'],
        tasks: ['newer:coffee:dist']
      },
      coffeeTest: {
        files: ['test/spec/**/*.{coffee,litcoffee,coffee.md}'],
        tasks: ['newer:coffee:test', 'karma']
      },
      compass: {
        files: ['<%= yeoman.app %>/styles/**/*.{scss,sass}'],
        tasks: ['compass:server', 'autoprefixer']
      },
      gruntfile: {
        files: ['Gruntfile.js']
      },
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          '<%= yeoman.app %>/**/*.html',
          '.tmp/styles/**/*.css',
          '.tmp/scripts/**/*.js',
          '<%= yeoman.app %>/images/**/*.{png,jpg,jpeg,gif,webp,svg}'
        ]
      }
    },

    // The actual grunt server settings
    connect: {
      options: {
        port: 9000,
        // Change this to '0.0.0.0' to access the server from outside.
        hostname: '0.0.0.0',
        livereload: 35729
      },
      livereload: {
        options: {
          open: true,
          middleware: function (connect) {
            return [
              connect.static('.tmp'),
              connect().use(
                '/bower_components',
                connect.static('./bower_components')
              ),
              connect().use('/api', function (req, res, cb) {

                req.url = req.url.replace(/^\/api/i, '');

                return require('http-proxy').createProxyServer().web(req, res, {
                  changeOrigin: true,
                  target: process.env.KITBAG_API_URL || 'http://localhost:3000/'
                }, function (err) {
                  cb(err);
                });

              }),
              modRewrite(['!\\.html|\\.js|\\.svg|\\.css|\\.png|\\.jpg|\\.ico|\\.txt$ /index.html [L]']),
              mountFolder(connect, 'app')
            ];
          }
        }
      },
      test: {
        options: {
          port: 9001,
          middleware: function (connect) {
            return [
              connect.static('.tmp'),
              connect.static('test'),
              connect().use(
                '/bower_components',
                connect.static('./bower_components')
              ),
              connect.static(appConfig.app)
            ];
          }
        }
      },
      dist: {
        options: {
          open: true,
          base: '<%= yeoman.dist %>'
        }
      }
    },

    // Make sure code styles are up to par and there are no obvious mistakes
    jshint: {
      options: {
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      all: {
        src: [
          'Gruntfile.js',
          '<%= yeoman.app %>/**/*.js',
          '<%= yeoman.test %>/**/*.js'
        ]
      }
    },

    // Empties folders to start fresh
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp',
            '.sass-cache',
            '<%= yeoman.constants %>',
            '<%= yeoman.dist %>/**/*',
            '!<%= yeoman.dist %>/.git**/*'
          ]
        }]
      },
      server: {
        files: [{
          src: [
            '.tmp',
            '.sass-cache',
            '<%= yeoman.constants %>'
          ]
        }]
      }
    },

    // Add vendor prefixed styles
    autoprefixer: {
      options: {
        browsers: ['last 1 version']
      },
      dist: {
        files: [{
          expand: true,
          cwd: '.tmp/styles/',
          src: '**/*.css',
          dest: '.tmp/styles/'
        }]
      }
    },

    // Automatically inject Bower components into the app
    wiredep: {
      app: {
        src: ['<%= yeoman.app %>/index.html'],
        ignorePath: /\.\.\//,
        exclude: [
          'bower_components/font-awesome/css/font-awesome.css',
          'bower_components/ngprogress-lite/ngprogress-lite.css',
          'bower_components/angular-schema-form/dist/bootstrap-decorator.js',
          'bower_components/angular-snap/angular-snap.css',
          'bower_components/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css'
        ]
      },
      sass: {
        src: ['<%= yeoman.app %>/styles/**/*.{scss,sass}'],
        ignorePath: /(\.\.\/){1,2}bower_components\//
      }
    },

    // Compiles CoffeeScript to JavaScript
    coffee: {
      options: {
        sourceMap: true,
        sourceRoot: ''
      },
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/scripts',
          src: '**/*.coffee',
          dest: '.tmp/scripts',
          ext: '.js'
        }]
      },
      test: {
        files: [{
          expand: true,
          cwd: 'test/spec',
          src: '**/*.coffee',
          dest: '.tmp/spec',
          ext: '.js'
        }]
      }
    },

    // Compiles Sass to CSS and generates necessary files if requested
    compass: {
      options: {
        sassDir: '<%= yeoman.app %>/styles',
        cssDir: '.tmp/styles',
        generatedImagesDir: '.tmp/images/generated',
        imagesDir: '<%= yeoman.app %>/images',
        javascriptsDir: '<%= yeoman.app %>/scripts',
        fontsDir: '<%= yeoman.app %>/styles/fonts',
        importPath: './bower_components',
        httpImagesPath: '/images',
        httpGeneratedImagesPath: '/images/generated',
        httpFontsPath: '/styles/fonts',
        relativeAssets: false,
        assetCacheBuster: false,
        raw: 'Sass::Script::Number.precision = 10\n'
      },
      dist: {
        options: {
          generatedImagesDir: '<%= yeoman.dist %>/images/generated'
        }
      },
      server: {
        options: {
          debugInfo: true
        }
      }
    },

    // Renames files for browser caching purposes
    filerev: {
      dist: {
        src: [
          '<%= yeoman.dist %>/scripts/**/*.js',
          '<%= yeoman.dist %>/styles/**/*.css',
          '<%= yeoman.dist %>/images/**/*.{png,jpg,jpeg,gif,webp,svg}',
          '<%= yeoman.dist %>/styles/fonts/*'
        ]
      }
    },

    // Reads HTML for usemin blocks to enable smart builds that automatically
    // concat, minify and revision files. Creates configurations in memory so
    // additional tasks can operate on them
    useminPrepare: {
      html: '<%= yeoman.app %>/index.html',
      options: {
        dest: '<%= yeoman.dist %>',
        flow: {
          html: {
            steps: {
              js: ['concat', 'uglifyjs'],
              css: ['cssmin']
            },
            post: {}
          }
        }
      }
    },

    // Performs rewrites based on filerev and the useminPrepare configuration
    usemin: {
      html: ['<%= yeoman.dist %>/**/*.html'],
      css: ['<%= yeoman.dist %>/styles/**/*.css'],
      options: {
        assetsDirs: ['<%= yeoman.dist %>', '<%= yeoman.dist %>/images']
      }
    },

    // The following *-min tasks will produce minified files in the dist folder
    // By default, your `index.html`'s <!-- Usemin block --> will take care of
    // minification. These next options are pre-configured if you do not wish
    // to use the Usemin blocks.
    // cssmin: {
    //   dist: {
    //     files: {
    //       '<%= yeoman.dist %>/styles/main.css': [
    //         '.tmp/styles/**/*.css'
    //       ]
    //     }
    //   }
    // },
    // uglify: {
    //   dist: {
    //     files: {
    //       '<%= yeoman.dist %>/scripts/scripts.js': [
    //         '<%= yeoman.dist %>/scripts/scripts.js'
    //       ]
    //     }
    //   }
    // },
    // concat: {
    //   dist: {}
    // },

    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/images',
          src: '**/*.{png,jpg,jpeg,gif}',
          dest: '<%= yeoman.dist %>/images'
        }]
      }
    },

    svgmin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/images',
          src: '**/*.svg',
          dest: '<%= yeoman.dist %>/images'
        }]
      }
    },

    htmlmin: {
      dist: {
        options: {
          collapseWhitespace: true,
          conservativeCollapse: true,
          collapseBooleanAttributes: true,
          removeCommentsFromCDATA: true,
          removeOptionalTags: true
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.dist %>',
          src: ['*.html', 'views/**/*.html'],
          dest: '<%= yeoman.dist %>'
        }]
      }
    },

    // ng-annotate tries to make the code safe for minification automatically
    // by using the Angular long form for dependency injection.
    ngAnnotate: {
      dist: {
        files: [{
          expand: true,
          cwd: '.tmp/concat/scripts',
          src: ['*.js', '!oldieshim.js'],
          dest: '.tmp/concat/scripts'
        }]
      }
    },

    // Replace Google CDN references
    cdnify: {
      dist: {
        html: ['<%= yeoman.dist %>/*.html']
      }
    },

    // Copies remaining files to places other tasks can use
    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>',
          dest: '<%= yeoman.dist %>',
          src: [
            '*.{ico,png,txt}',
            '.htaccess',
            '*.html',
            'views/**/*.html',
            'images/**/*.{webp}',
            'fonts/**/*.*'
          ]
        }, {
          expand: true,
          cwd: '.tmp/images',
          dest: '<%= yeoman.dist %>/images',
          src: ['generated/*']
        }, {
          expand: true,
          cwd: '.',
          src: 'bower_components/bootstrap-sass-official/assets/fonts/bootstrap/*',
          dest: '<%= yeoman.dist %>'
        }, {
          expand: true,
          cwd: '.',
          src: 'bower_components/font-awesome/fonts/*',
          dest: '<%= yeoman.dist %>'
        }, {
          expand: true,
          cwd: '<%= yeoman.app %>',
          dest: '<%= yeoman.dist %>',
          src: [
            'scripts/i18n/**/*.json',
            'scripts/schema/**/*.json'
          ]
        }]
      },
      styles: {
        expand: true,
        cwd: '<%= yeoman.app %>/styles',
        dest: '.tmp/styles/',
        src: '**/*.css'
      }
    },

    // Run some tasks in parallel to speed up the build process
    concurrent: {
      server: [
        'coffee:dist',
        'compass:server'
      ],
      test: [
        'coffee',
        'compass'
      ],
      dist: [
        'coffee',
        'compass:dist',
        'imagemin',
        'svgmin'
      ]
    },

    // Test settings
    karma: {
      unit: {
        configFile: 'test/karma.conf.coffee',
        singleRun: Boolean(process.env.CI_ENV)
      }
    },

    jsonlint: {
      app: {
        src: [
          './*.json',
          './<%= yeoman.app %>/**/*.json',
          './<%= yeoman.test %>/**/*.json'
        ]
      }
    },

    jscs: {
      options: {
        config: '.jscsrc'
      },
      src: {
        files: {
          src: [
            'Gruntfile.js',
            './<%= yeoman.app %>/**/*.js'
          ]
        }
      },
      test: {
        files: {
          src: [
            './<%= yeoman.test %>/**/*.js'
          ]
        }
      }
    },

    coffeelint: {
      options: {
        'indentation': {
          value: 2
        },
        'max_line_length': {
          value: 120,
          level: 'error'
        }
      },
      app: {
        files: {
          src: [
            '<%= yeoman.app %>/**/*.coffee',
            '<%= yeoman.test %>/**/*.coffee'
          ]
        }
      }
    },


    removelogging: {
      tmp: {
        src: '.tmp/**/*.js'
      }
    },


    ngconstant: {

      options: {
        dest: '.tmp/ngconstants/envvars.js',
        name: 'config',
        space: '  ',
        wrap: '"use strict";\n\n {%= __ngModule %}'
      },

      development: {
        constants: {
          ENV: {
            name: 'development',
            version: pkg.version
          }
        }
      },
      production: {
        constants: {
          ENV: {
            name: 'production',
            version: pkg.version
          }
        }
      }

    },


    js2coffee: {

      ngconstants: {
        src: '.tmp/ngconstants/envvars.js',
        dest: '<%= yeoman.constants %>'
      }

    },


    ngtemplates: {
      kitbagApp: {
        options: {
          htmlmin: {
            collapseBooleanAttributes: true,
            collapseWhitespace: true,
            removeAttributeQuotes: true,
            removeEmptyAttributes: true,
            removeRedundantAttributes: true,
            removeScriptTypeAttributes: true,
            removeStyleLinkTypeAttributes: true
          },
          bootstrap: function (module, script, options) {

            /* Copied from package - changed quotes to pass linting */
            var def = options.angular + '.module("' + module + '"' + (options.standalone ? ', []' : '') + ').run(["$templateCache", function($templateCache) {\n' + script + '\n}]);\n';

            /* Wrap the bootstrap in an IIFE */
            return '(function () { "use strict"; ' + def + '}).call(this);';

          }
        },
        cwd: '<%= yeoman.dist %>',
        src: 'views/**/*.html',
        dest: '.tmp/templates.js'
      }
    },


    uglify: {
      options: {
        /* Not mangling as problem in the vendor stuff which I can't work out */
        mangle: false
      },
      templates: {
        files: {
          '.tmp/templates.min.js': [
            '.tmp/templates.js'
          ]
        }
      }
    },


    concat: {
      templates: {
        src: [
          '<%= yeoman.dist %>/scripts/scripts.*',
          '.tmp/templates.min.js'
        ],
        dest: '.tmp/dist.js'
      }
    }

  });


  grunt.registerTask('serve', 'Compile then start a connect web server', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['build', 'connect:dist:keepalive']);
    }

    grunt.task.run([
      'clean:server',
      'ngconstant:development',
      'js2coffee:ngconstants',
      'wiredep',
      'concurrent:server',
      'autoprefixer',
      'connect:livereload',
      'watch'
    ]);
  });

  grunt.registerTask('lint', [
    'jshint:all',
    'jsonlint:app',
    'jscs',
    'coffeelint'
  ]);

  grunt.registerTask('test', [
    'clean:server',
    'ngconstant:development',
    'js2coffee:ngconstants',
    'concurrent:test',
    'autoprefixer',
    'lint',
    'connect:test',
    'karma'
  ]);

  grunt.registerTask('build', [
    'clean:dist',
    'ngconstant:production',
    'js2coffee:ngconstants',
    'wiredep',
    'useminPrepare',
    'concurrent:dist',
    'autoprefixer',
    'lint',
    'concat',
    'ngAnnotate',
    'copy:dist',
    'cdnify',
    'cssmin',
    'removelogging:tmp',
    'uglify',
    'filerev',
    'usemin',
    'ngtemplates',
    'uglify:templates',
    'concat:templates',
    'copyscripts'
  ]);

  grunt.registerTask('default', [
    'newer:jshint',
    'test',
    'build'
  ]);

  grunt.registerTask('copyscripts', 'Copies the scripts with the templates back to dist', function () {

    var done = this.async();

    var dist = grunt.config.get('yeoman.dist');
    var tmp = '.tmp';

    /* Find the destination filename */
    var contents = fs.readdirSync(dist + '/scripts');
    var filename = null;

    if (contents instanceof Array) {

      contents.forEach(function (file) {
        if (file.match(/^scripts/)) {
          filename = file;
        }
      });

      if (filename === null) {
        grunt.fail.fatal('Cannot find a compiled scripts file');
      }

    } else {
      grunt.fail.fatal('No files in dist/scripts folder');
    }

    /* Move the minified temp */
    fs.copy(tmp + '/dist.js', dist + '/scripts/' + filename, function (err) {

      if (err) {
        grunt.log.error(err);
        return false;
      }

      done();

    });

  });

};
