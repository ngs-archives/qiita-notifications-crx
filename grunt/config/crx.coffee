module.exports = (grunt, config) ->
  assistant:
    src: '<%= config.build %>'
    dest: '<%= config.dist %>/<%= config.crxname %>'
    privateKey: process.env.CRX_PRIVATE_KEY || '~/.ssh/qiita-chrome.pem'
    exclude: ['.DS_Store']
