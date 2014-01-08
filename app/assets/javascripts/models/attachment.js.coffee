Founden.Attachment = Ember.Model.extend Founden.TimeAgoMixin,
  title: Ember.attr()
  createdAt: Ember.attr('date', readOnly: true, defaultValue: new Date)

  user: Ember.belongsTo('user', key: 'user_id', readOnly: true)
  message: Ember.belongsTo('message', key: 'message_id')
  conversation: Ember.belongsTo('conversation', key: 'conversation_id')

Founden.Attachment.reopenClass
  url: Founden.Attachment.url + 'attachments'
  collectionKey: 'attachments'
