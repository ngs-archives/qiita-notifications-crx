module.exports = (grunt, config) ->
  js:
    dest: '<%= config.app %>/scripts/application.js'
    src: '<%= config.urls.js %>'
  css:
    dest: '<%= config.app %>/styles/application.css'
    src: '<%= config.urls.css %>'