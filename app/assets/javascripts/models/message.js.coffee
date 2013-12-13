Founden.Message = DS.Model.extend Founden.TimeAgoMixin,
  isFocused: false

  content: DS.attr('string')
  createdAt: DS.attr('date', readOnly: true, defaultValue: new Date)
  isSummary: DS.attr('boolean', readOnly: true)
  isUnread: DS.attr('boolean', readOnly: true)

  user: DS.belongsTo('user')
  conversation: DS.belongsTo('conversation')
  network: DS.belongsTo('network')
  parentMessage: DS.belongsTo('message', inverse: 'replies')
  conversation: DS.belongsTo('conversation')
  summary: DS.belongsTo('summary')
  attachments: DS.hasMany('attachment', polymorphic: true, defaultValue: [], async: true)
  replies: DS.hasMany('message', inverse: 'parentMessage', defaultValue: [])
