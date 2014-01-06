Founden.Attachment = Ember.Model.extend Founden.TimeAgoMixin,
  title: Ember.attr()
  createdAt: Ember.attr('date', readOnly: true, defaultValue: new Date)

  user: Ember.belongsTo('user', readOnly: true)
  message: Ember.belongsTo('message')
  conversation: Ember.belongsTo('conversation')
  network: Ember.belongsTo('network')

Founden.Attachment.reopenClass
  url: Founden.Attachment.url + 'attachments'
  collectionKey: 'attachments'
