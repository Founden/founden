Founden.Summary = DS.Model.extend Founden.TimeAgoMixin,
  createdAt: DS.attr('date')

  conversation: DS.belongsTo('conversation', async: true)
  messages: DS.hasMany('message', async: true)

  identifier: (->
    'summary-' + @get('id')
  ).property('id')
