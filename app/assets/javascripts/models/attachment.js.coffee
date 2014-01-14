Founden.Attachment = DS.Model.extend Founden.TimeAgoMixin,
  title: DS.attr('string')
  createdAt: DS.attr('date', readOnly: true, defaultValue: new Date)

  user: DS.belongsTo('user', readOnly: true)
  message: DS.belongsTo('message')
  conversation: DS.belongsTo('conversation')
