Founden.Message = Ember.Model.extend Founden.TimeAgoMixin,
  isFocused: false

  content: Ember.attr()
  createdAt: Ember.attr('date', readOnly: true, defaultValue: new Date)
  isUnread: Ember.attr('boolean', readOnly: true)
  summaryId: Ember.attr('booleanish')

  user: Ember.belongsTo('user')
  conversation: Ember.belongsTo('conversation')
  network: Ember.belongsTo('network')
  parentMessage: Ember.belongsTo('message', inverse: 'replies')
  conversation: Ember.belongsTo('conversation')
  attachments: Ember.hasMany('attachment', embedded: 'polymorphic', key: 'attachments')
  replies: Ember.hasMany('message', inverse: 'parentMessage', defaultValue: [])

Founden.Message.rootKey = 'message'
Founden.Message.collectionKey = 'messages'
Founden.Message.url += 'messages'
