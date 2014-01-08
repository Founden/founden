Founden.Conversation = Ember.Model.extend Founden.TimeAgoMixin,
  title: Ember.attr()
  createdAt: Ember.attr('date', readOnly: true, defaultValue: new Date)
  isUnread: Ember.attr('boolean', readOnly: true)

  user: Ember.belongsTo('user', key: 'user_id', readOnly: true)
  summary: Ember.belongsTo('summary', readOnly: true)
  participants: Ember.hasMany('user', embeded: true)
  messages: Ember.hasMany('message', embeded: true)

Founden.Conversation.rootKey = 'conversation'
Founden.Conversation.collectionKey = 'conversations'
Founden.Conversation.url += 'conversations'
