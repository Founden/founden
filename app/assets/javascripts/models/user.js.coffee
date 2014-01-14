Founden.User = DS.Model.extend
  firstName: DS.attr('string')
  lastName: DS.attr('string')
  avatarUrl: DS.attr('string')

  conversations: DS.hasMany('conversation', key: 'conversation_ids', async: true)
  contacts: DS.hasMany('user', key: 'contact_ids', async: true)

  name: ( ->
    @get('firstName') + ' ' + @get('lastName')
  ).property('firstName', 'lastName')
