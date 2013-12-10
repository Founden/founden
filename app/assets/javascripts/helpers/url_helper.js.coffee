Ember.Handlebars.helper 'url_domain', (value) ->
  if value and (match = value.match('https?://([a-z\-.]+)'))
    match[1]
