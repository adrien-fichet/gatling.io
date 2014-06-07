module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig

    pkg: grunt.file.readJSON('package.json')

    clean:
      all:
        src: 'dist'

    uglify:
      all:
        files:
          'dist/assets/javascripts/commons.min.js': 'app/assets/javascripts/commons.js'

    less:
      development:
        options:
          paths: ['app/assets/less']
        files: [
          'dist/assets/css/style.css': 'app/assets/less/style/*.less'
          'dist/assets/css/mobile.css': 'app/assets/less/mobile/*.less'
        ]
      production:
        options:
          cleancss: true
          paths: ['app/assets/less']
        files: [
          'dist/assets/css/style.min.css': 'app/assets/less/style/*.less'
          'dist/assets/css/mobile.min.css': 'app/assets/less/mobile/*.less'
        ]

    copy:
      main:
        files: [
          # config
          {
            expand: true
            flatten: true
            src: 'config/*'
            dest: 'dist/'
          }
          # images
          {
            expand: true
            flatten: true
            src: 'app/assets/images/*.*'
            dest: 'dist/assets/images/'
          }
          # bower css dependencies
          {
            expand: true
            flatten: true
            cwd: 'bower_components/'
            src: [
              '**/bootstrap.min.css'
              '**/bootstrap-theme.min.css'
            ]
            dest: 'dist/vendor/css/'
          }
          # bower javascripts dependencies
          {
            expand: true
            flatten: true
            cwd: 'bower_components/'
            src: [
              '**/bootstrap.min.js'
              '**/jquery.min.js'
            ]
            dest: 'dist/vendor/javascripts/'
          }
          # manual dependencies
          {
            expand: true
            flatten: true
            cwd: 'app/vendor/'
            src: [
              'html5shiv/*.min.js'
              'modernizr/*.min.js'
              'pie/*.min.js'
              'prettify/lang-scala.js'
              'prettify/prettify.min.js'
            ]
            dest: 'dist/vendor/javascripts/'
          }
          # html
          {
            expand: true
            flatten: true
            src: 'app/views/*.html'
            dest: 'dist/'
          }
        ]

    preprocess:
      html:
        options:
          inline: true
        src: 'dist/*.html'

    connect:
      server:
        options:
          base: 'dist'
          port: 3000
          keepalive: true

  # Tasks

  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-preprocess')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-connect')

  # Default task

  grunt.registerTask('default', ['clean', 'uglify', 'less:development', 'copy', 'preprocess:html'])

  return
