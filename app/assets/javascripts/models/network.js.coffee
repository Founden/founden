Founden.Network = DS.Model.extend
  isHidden: DS.attr('boolean', readOnly: true)
  title: DS.attr('string')

  conversations: DS.hasMany('conversation', async: true)
  contacts: DS.hasMany('user', async: true)
