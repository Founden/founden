Founden.User = DS.Model.extend
  firstName: DS.attr('string')
  lastName: DS.attr('string')
  avatarUrl: DS.attr('string')

  conversations: DS.hasMany('conversation', async: true)
  contacts: DS.hasMany('user', async: true)
  summaries: DS.hasMany('summary', async: true)

  name: ( ->
    @get('firstName') + ' ' + @get('lastName')
  ).property('firstName', 'lastName')
