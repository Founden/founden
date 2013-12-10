Ember.Handlebars.helper 'filesize', (bytes) ->
  sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB']
  if (bytes == 0)
    return 'n/a'
  i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)))
  return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[[i]]
