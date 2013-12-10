Founden.Attachment = DS.Model.extend Founden.TimeAgoMixin,
  title: DS.attr('string')
  createdAt: DS.attr('date')

  user: DS.belongsTo('user')
