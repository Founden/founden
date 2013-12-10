Founden.Network = DS.Model.extend
  isHidden: DS.attr('boolean')
  title: DS.attr('string')

  inbox: DS.hasMany('conversation', async: true)
  ongoing: DS.hasMany('conversation', async: true)
