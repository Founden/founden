Founden.Invitation = DS.Model.extend Founden.TimeAgoMixin,
  email: DS.attr('string')
  networkTitle: DS.attr('string', readOnly: true)
  createdAt: DS.attr('date', readOnly: true, defaultValue: new Date)

  user: DS.belongsTo('user')
  network: DS.belongsTo('network')
  membership: DS.belongsTo('membership')
