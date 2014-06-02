module.exports = (grunt, config) ->
  app:
    expand: yes
    cwd:  '<%= config.app %>'
    src:  [
      '**/*.js'
      '!bower_components/**/*.js'
      'bower_components/jquery/dist/jquery.js'
      'bower_components/backbone/backbone.js'
      'bower_components/underscore/underscore.js'
    ]
    dest: '<%= config.build %>'
