Founden.Membership = DS.Model.extend
  user: DS.belongsTo('user', inverse: 'friendships')
  creator: DS.belongsTo('user', inverse: 'createdFriendships')
  conversation: DS.belongsTo('conversation')
