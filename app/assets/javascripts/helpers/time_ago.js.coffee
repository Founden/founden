Ember.Handlebars.helper 'timeago', (timestamp) ->
  if timestamp
    moment(timestamp).fromNow()
  else
    'N/A'

Ember.Handlebars.helper 'datetime', (timestamp, options) ->
  format = options.hash.format || 'MMMM Do YYYY, h:mm:ss'
  moment(timestamp).format(format)

Ember.Handlebars.helper 'date', (timestamp, options) ->
  format = options.hash.format || 'MMMM Do YYYY'
  moment(timestamp).format(format)

Ember.Handlebars.helper 'time', (timestamp, options) ->
  format = options.hash.format || 'hh:mm:ss'
  moment(timestamp).format(format)
