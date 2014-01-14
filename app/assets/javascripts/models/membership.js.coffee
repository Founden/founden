Founden.Membership = DS.Model.extend
  user: DS.belongsTo('user')
  conversation: DS.belongsTo('conversation')
