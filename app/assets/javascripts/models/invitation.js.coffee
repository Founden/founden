Founden.Invitation = DS.Model.extend Founden.TimeAgoMixin,
  email: DS.attr('string')
  createdAt: DS.attr('date', readOnly: true, defaultValue: new Date)

  user: DS.belongsTo('user')
  membership: DS.belongsTo('membership')
