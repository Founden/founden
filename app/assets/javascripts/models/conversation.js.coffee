Founden.Conversation = DS.Model.extend Founden.TimeAgoMixin,
  title: DS.attr('string')
  createdAt: DS.attr('date', readOnly: true, defaultValue: new Date)
  isUnread: DS.attr('boolean', readOnly: true)

  user: DS.belongsTo('user', readOnly: true)
  summary: DS.belongsTo('summary', readOnly: true)
  participants: DS.hasMany('user', async: true)
  messages: DS.hasMany('message', async: true)

  identifier: (->
    'conversation-' + @get('id')
  ).property('id')
