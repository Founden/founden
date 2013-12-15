Founden.Membership = DS.Model.extend
  user: DS.belongsTo('user')
  network: DS.belongsTo('network')
  conversation: DS.belongsTo('conversation')
