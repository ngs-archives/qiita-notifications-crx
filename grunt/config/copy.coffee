module.exports = (grunt, config) ->
  src:
    expand: yes
    cwd:  '<%= config.src %>'
    src:  'images/*.png'
    dest: '<%= config.app %>'
  app:
    expand: yes
    cwd:  '<%= config.app %>'
    src:  [
      '**/*.{html,json,css,png}'
      '!bower_components/**/*'
      'bower_components/*/dist/**/*.min.css'
    ]
    dest: '<%= config.build %>'
