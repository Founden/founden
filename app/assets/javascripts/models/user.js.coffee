Founden.User = DS.Model.extend
  firstName: DS.attr('string')
  lastName: DS.attr('string')
  avatarUrl: DS.attr('string')

  networks: DS.hasMany('network')

  name: ( ->
    @get('firstName') + ' ' + @get('lastName')
  ).property('firstName', 'lastName')
