Founden.User = Ember.Model.extend
  firstName: Ember.attr()
  lastName: Ember.attr()
  avatarUrl: Ember.attr()

  contacts: Ember.hasMany('user', key: 'contact_ids')

  name: ( ->
    @get('firstName') + ' ' + @get('lastName')
  ).property('firstName', 'lastName')

Founden.User.rootKey = 'user'
Founden.User.collectionKey = 'users'
Founden.User.url += 'users'
