Founden.User = Ember.Model.extend
  firstName: Ember.attr()
  lastName: Ember.attr()
  avatarUrl: Ember.attr()

  conversations: Ember.hasMany('conversation', key: 'conversation_ids', embeded: true)
  contacts: Ember.hasMany('user', key: 'contact_ids')

  name: ( ->
    @get('firstName') + ' ' + @get('lastName')
  ).property('firstName', 'lastName')

Founden.User.rootKey = 'user'
Founden.User.collectionKey = 'users'
Founden.User.url += 'users'
