Founden.Conversation = Ember.Model.extend Founden.TimeAgoMixin,
  title: Ember.attr()
  createdAt: Ember.attr('date', readOnly: true)
  isUnread: Ember.attr('boolean', readOnly: true)

  user: Ember.belongsTo('user', key: 'user_id', readOnly: true)
  summary: Ember.belongsTo('summary', readOnly: true)
  participants: Ember.hasMany('user', embeded: true)
  messages: Ember.hasMany('message', key: 'message_ids', embeded: true)

  identifier: (->
    'conversation-' + @get('id')
  ).property('id')

Founden.Conversation.rootKey = 'conversation'
Founden.Conversation.collectionKey = 'conversations'
Founden.Conversation.url += 'conversations'
