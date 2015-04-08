'use strict'
#
# FastChat
# 2015
#

module.exports = (grunt)->
  grunt.initConfig
    build:
      app: 'app'
      compiled:
        app: '_app'
    pkg: grunt.file.readJSON('package.json')
    env: '<% process.env.NODE_ENV %>'
    clean: ['<%= build.compiled.app %>']
    copy:
      images:
        files: [
          {
            expand: yes
            cwd: '<%= build.app %>/img'
            src: ['**/*.{png,jpg,jpeg,gif,svg}']
            dest: '<%= build.compiled.app %>/img'
          }
        ]
    jade:
      compile:
        options:
          client: no
          amd: no
          namespace: no
          pretty: yes
          data: '<%= context %>'
        files: [
          {
            expand: yes
            cwd: '<%= build.app %>'
            src: ['**/*.jade']
            dest: '<%= build.compiled.app %>'
            ext: '.html'
          }
        ]
    coffee:
      all:
        options: {}
        files: [
          {
            expand: yes
            cwd: '<%= build.app %>'
            src: ['**/*.coffee']
            dest: '<%= build.compiled.app %>/'
            ext: '.js'
          }
        ]
    less:
      all:
        options: {}
        files: [
          {
            expand: yes
            cwd: '<%= build.app %>'
            src: ['**/*.less']
            dest: '<%= build.compiled.app %>/'
            ext: '.css'
          }
        ]
    bower_concat:
      all:
        dest: '<%= build.compiled.app %>/js/scripts/compiled.js'
        cssDest: '<%= build.compiled.app %>/css/compiled.css'
    watch:
      options:
        livereload: yes
      jade:
        tasks: ['jade']
        files: ['<%= build.app %>/**/*.jade']
      coffee:
        tasks: ['coffee']
        files: ['<%= build.app %>/**/*.coffee']
      less:
        tasks: ['less']
        files: ['<%= build.app %>/**/*.less']
      images:
        tasks: ['copy:images']
        files: ['<%= build.app %>/**/*.{png,svg,jpg,jpeg,gif}']


  require('load-grunt-tasks')(grunt)
  grunt.registerTask('default', [])
  grunt.registerTask 'compile', [
    'clean'
    'jade'
    'bower_concat'
    'coffee'
    'less'
    'copy:images'
  ]
