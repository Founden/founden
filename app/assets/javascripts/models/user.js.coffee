Founden.User = DS.Model.extend
  firstName: DS.attr('string')
  lastName: DS.attr('string')
  avatarUrl: DS.attr('string')

  conversations: Ember.hasMany('conversation', key: 'conversation_ids', embeded: true)
  contacts: Ember.hasMany('user', key: 'contact_ids')

  name: ( ->
    @get('firstName') + ' ' + @get('lastName')
  ).property('firstName', 'lastName')
