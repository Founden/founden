Founden.Conversation = DS.Model.extend Founden.TimeAgoMixin,
  title: DS.attr('string')
  createdAt: DS.attr('date', readOnly: true, defaultValue: new Date)
  isUnread: DS.attr('boolean', readOnly: true)

  user: DS.belongsTo('user', readOnly: true)
  network: DS.belongsTo('network', readOnly: true)
  summary: DS.belongsTo('summary', readOnly: true)
  people: DS.hasMany('user')
  messages: DS.hasMany('message')
