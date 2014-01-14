Founden.Message = Ember.Model.extend Founden.TimeAgoMixin,
  isFocused: false

  content: Ember.attr()
  createdAt: Ember.attr('date', readOnly: true)
  isUnread: Ember.attr('boolean', readOnly: true)
  summaryId: Ember.attr('boolean')

  user: Ember.belongsTo('user', key: 'user_id', readOnly: true)
  conversation: Ember.belongsTo('conversation', key: 'conversation_id')
  parentMessage: Ember.belongsTo('message', key: 'parent_message_id')
  attachments: Ember.hasMany('attachment', embedded: 'polymorphic', key: 'attachments')
  replies: Ember.hasMany('message', key: 'reply_ids')

Founden.Message.rootKey = 'message'
Founden.Message.collectionKey = 'messages'
Founden.Message.url += 'messages'
