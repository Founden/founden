Founden.Message = DS.Model.extend Founden.TimeAgoMixin,
  isFocused: false

  content: DS.attr('string')
  createdAt: DS.attr('date', readOnly: true, defaultValue: new Date)
  isUnread: DS.attr('boolean', readOnly: true)
  summaryId: DS.attr('booleanish')

  user: DS.belongsTo('user')
  parentMessage: DS.belongsTo('message', inverse: 'replies')
  conversation: DS.belongsTo('conversation')
  attachments: DS.hasMany('attachment', polymorphic: true, defaultValue: [], async: true)
  replies: DS.hasMany('message', inverse: 'parentMessage', defaultValue: [])
