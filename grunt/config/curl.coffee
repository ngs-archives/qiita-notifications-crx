module.exports = (grunt, config) ->
  js:
    dest: '<%= config.app %>/vendor/application.js'
    src: '<%= config.urls.js %>'
  css:
    dest: '<%= config.app %>/vendor/application.css'
    src: '<%= config.urls.css %>'
  ga:
    dest: '<%= config.app %>/vendor/google-analytics-bundle.js'
    src: '<%= config.urls.ga %>'

