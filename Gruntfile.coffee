module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

  #----------------------
  #   Variables

    paths:
      libSrcPath: "bower_components"
      jsLibPath: "src/app/lib"
      sassLibPath: "src/styles/lib"


  #----------------------
  #   Concat

    concat:
      dist:
        src: [
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
          "src/app/lib"
          "src/styles/lib"
        ]

    copy:
      #development depencies
      libs: 
        files: [
          #javascript libraries
          {
            cwd: "<%= paths.libSrcPath %>"
            src: [
              "angular/angular.js"
              "angular-ui-router/release/angular-ui-router.js"
            ]
            dest: "<%= paths.jsLibPath %>"
            expand: true
          }
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
          "src/styles.min.css": ["src/styles/main.css"]


#----------------------------
#   Load tasks
           
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-watch"


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


  return