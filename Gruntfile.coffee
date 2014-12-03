module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

  #----------------------
  #   Variables

    paths:
      libSrcPath: "bower_components"
      jsLibPath: "src/lib"
      sassLibPath: "src/styles/lib"


  #----------------------
  #   Concat

    concat:
      dev:
        src: [
          "<%= paths.libSrcPath %>/angular/angular.js",
          "<%= paths.libSrcPath %>/angular-ui-router/release/angular-ui-router.js",
          "src/app/**/*.module.js",
          "src/app/**/*.js"
        ]
        dest: "src/app.js"

  #----------------------
  #   Watch

    watch:
      src: {
        files: [
          "Gruntfile.js"
          "src/index.html"
          "src/app/**"
          "src/styles/**"
        ]
        tasks: [
          "concat"
          "sass"
          "cssmin"
        ]
        options:
          spawn: false
          hostname: "localhost"
          livereload: "<%= connect.options.livereload %>"
      }

      #if a new dependency is added
      dependencies: {
        files: [
          "<%= paths.libSrcPath %>"
        ]
        tasks: [
          "clean:libs"
          "copy:libs"
        ]
      }

    
  #----------------------
  #   Livereload
  
    connect:
      options:
        port: 9000
        
        # Change this to '0.0.0.0' to access the server from outside.
        hostname: "localhost"
        livereload: 35729

      livereload:
        options:
          open: true
          base: ["src"]

    
  #----------------------
  #   Copy & Clean

    clean:
      build:
        src: ["dist"]

      libs:
        src: [
          "src/styles/lib"
        ]

    copy:
      #development depencies
      libs: 
        files: [
          #sass libraries
          {
            cwd: "<%= paths.libSrcPath %>"
            src: [
              "**/*.scss"
            ]
            dest: "<%= paths.sassLibPath %>"
            expand: true
          }
        ]

      build:
        files: [
          {
            cwd: "src"
            src: [
              "index.html",
              "app.js",
              "styles/styles.min.css",
              "assets/**",
              "app/**/*.html"
            ]
            dest: "dist"
            expand: true
          }
        ]


  #----------------------
  #   sass & cssmin

    sass:
      dist:
        files:
          "src/styles/main.css": "src/styles/main.scss"

    cssmin:
      add_banner:
        options:
          banner: "/* minified css file */"

        files:
          "src/styles/styles.min.css": ["src/styles/main.css"]

  #----------------------
  #   testing

    karma:   
      unit: 
        options: 
          frameworks: ['jasmine']
          singleRun: true
          browsers: ['PhantomJS']
          files: [
            "<%= paths.libSrcPath %>/angular/angular.js"
            "<%= paths.libSrcPath %>/angular-mocks/angular-mocks.js"
            "<%= paths.libSrcPath %>/angular-ui-router/release/angular-ui-router.js"
            "<%= paths.libSrcPath %>/angular-data/dist/angular-data.js"
            "src/app/**/*.module.js"
            "src/app/**/*.js"
          ]



#----------------------------
#   Load tasks

  require('matchdep').filterAll('grunt-*').forEach(grunt.loadNpmTasks);


#----------------------------
#   Register tasks

  grunt.registerTask "go", [
    "clean:libs", 
    "copy:libs",
    "concat",
    "sass",
    "connect",
    "watch"
  ]

  grunt.registerTask "build", [
    "clean:build",
    "concat",
    "sass",
    "cssmin",
    "copy:build"
  ]

  grunt.registerTask "test", [  
    "karma"
  ]

  return