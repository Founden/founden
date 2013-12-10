Founden.Message = DS.Model.extend Founden.TimeAgoMixin,
  isFocused: false

  content: DS.attr('string')
  createdAt: DS.attr('date')
  isSummary: DS.attr('boolean')
  isUnread: DS.attr('boolean')

  user: DS.belongsTo('user', async: true)
  parentMessage: DS.belongsTo('message', async: true, inverse: 'replies')
  conversation: DS.belongsTo('conversation', async: true)
  summary: DS.belongsTo('summary', async: true)
  attachments: DS.hasMany('attachment', polymorphic: true, async: true)
  replies: DS.hasMany('message', async: true, inverse: 'parentMessage')
