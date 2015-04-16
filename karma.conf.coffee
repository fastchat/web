'use strict'
#
# FastChat
# 2015
#

module.exports = (config)->
  config.set({
    preprocessors: {
      '**/*.coffee': ['coffee']
    }

    coffeePreprocessor:
      options:
        bare: true
        sourceMap: yes
      transformPath: (path)->
        path.replace(/\.coffee$/, '.js')

    basePath : './'
    files : [
      'bower_components/angular/angular.js'
      'bower_components/angular-route/angular-route.js'
      'bower_components/angular-mocks/angular-mocks.js'
      '_app/**/*.js'
      'test/unit/**'
    ]

    autoWatch : true
    frameworks: ['jasmine']
    browsers : ['Chrome']

    plugins : [
      'karma-chrome-launcher'
      'karma-jasmine'
      'karma-coffee-preprocessor'
      ]
  })

