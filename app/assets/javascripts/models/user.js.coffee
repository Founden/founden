Founden.User = DS.Model.extend
  firstName: DS.attr('string')
  lastName: DS.attr('string')
  avatarUrl: DS.attr('string')

  conversations: DS.hasMany('conversation', async: true)
  contacts: DS.hasMany('user', async: true)
  summaries: DS.hasMany('summary', async: true)
  createdFriendships: DS.hasMany('membership', async: true, inverse: 'creator')
  friendships: DS.hasMany('membership', async: true, inverse: 'user')

  name: ( ->
    @get('firstName') + ' ' + @get('lastName')
  ).property('firstName', 'lastName')
