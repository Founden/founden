Founden.Summary = Ember.Model.extend Founden.TimeAgoMixin,
  createdAt: Ember.attr('date', readOnly: true)

  conversation: Ember.belongsTo('conversation', key: 'conversation_id')
  messages: Ember.hasMany('message', key: 'message_ids')

Founden.Summary.rootKey = 'summary'
Founden.Summary.collectionKey = 'summaries'
Founden.Summary.url += 'summaries'
