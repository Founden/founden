Founden.User = DS.Model.extend
  name: DS.attr('string')
  avatarUrl: DS.attr('string')

  networks: DS.hasMany('network')
