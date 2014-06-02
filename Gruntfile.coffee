'use strict'

require('dotenv').load()

CSON = require 'cson-safe'

module.exports = (grunt) ->

  require('load-grunt-tasks') grunt
  require('time-grunt') grunt

  grunt.registerTask 'default', ['dev']
  grunt.registerTask 'dev',     ['bower-install', 'curl', 'cson', 'jade:src', 'coffee', 'compass', 'wiredep', 'copy:src']
  grunt.registerTask 'build',   ['dev', 'uglify', 'copy:app']
  grunt.registerTask 'dist',    ['build', 'crx', 'compress']
  grunt.loadTasks './grunt/tasks'

  config =
    app:      'app'
    src:      'src'
    build:    'build'
    dist:     'dist'
    crxname:  'qiita-notifications-<%= config.manifest.version %>.crx'
    zipname:  'qiita-notifications-<%= config.manifest.version %>.zip'
    s3bucket: process.env.S3_BUCKET
    s3url:    'https://<%= config.s3bucket %>.s3.amazonaws.com'
    crxurl:   '<%= config.s3url %>/<%= config.crxname %>'
    s3path:   ''
    manifest: CSON.parse grunt.file.read 'src/manifest.cson'
    urls:
      js:  'https://qiita.com/assets/application-5c0286ec6333f54b79fecce9e4cbd0d2.js'
      css: 'http://qiita.com/assets/public-application-df5485504b5193351f135d181fb40378.css'
      ga:  'https://raw.githubusercontent.com/GoogleChrome/chrome-platform-analytics/master/google-analytics-bundle.js'

  if process.env.TRAVIS
    config.s3path = "travis/#{process.env.TRAVIS_BRANCH}/#{process.env.TRAVIS_BUILD_NUMBER}/"

  noext = (fn)-> fn.replace(/\.coffee$/, '')

  gruntConfig = config: config
  grunt.file.recurse './grunt/config', (abspath, rootdir, subdir, filename)->
    if /\.coffee$/.test filename
      gruntConfig[noext filename] = require("./#{noext abspath}") grunt, config

  grunt.initConfig gruntConfig
