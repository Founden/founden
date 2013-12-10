Founden.Conversation = DS.Model.extend Founden.TimeAgoMixin,
  title: DS.attr('string')
  createdAt: DS.attr('date')
  isUnread: DS.attr('boolean')

  user: DS.belongsTo('user')
  summary: DS.belongsTo('summary', async: true)
  people: DS.hasMany('user', async: true)
  messages: DS.hasMany('message', async: true)
