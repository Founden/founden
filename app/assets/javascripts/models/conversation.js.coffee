Founden.Conversation = Ember.Model.extend Founden.TimeAgoMixin,
  title: Ember.attr()
  createdAt: Ember.attr('date', readOnly: true, defaultValue: new Date)
  isUnread: Ember.attr('boolean', readOnly: true)

  user: Ember.belongsTo('user', readOnly: true)
  network: Ember.belongsTo('network', readOnly: true)
  summary: Ember.belongsTo('summary', readOnly: true)
  participants: Ember.hasMany('user', async: true)
  messages: Ember.hasMany('message', async: true)

Founden.Conversation.rootKey = 'conversation'
Founden.Conversation.collectionKey = 'conversations'
Founden.Conversation.url += 'conversations'
