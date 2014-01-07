Founden.Summary = Ember.Model.extend Founden.TimeAgoMixin,
  createdAt: Ember.attr('date')

  conversation: Ember.belongsTo('conversation', async: true)
  messages: Ember.hasMany('message', async: true)

Founden.Summary.rootKey = 'summary'
Founden.Summary.collectionKey = 'summaries'
Founden.Summary.url += 'summaries'
