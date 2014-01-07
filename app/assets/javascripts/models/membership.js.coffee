Founden.Membership = Ember.Model.extend
  user: Ember.belongsTo('user')
  network: Ember.belongsTo('network')
  conversation: Ember.belongsTo('conversation')

Founden.Membership.rootKey = 'membership'
Founden.Membership.collectionKey = 'memberships'
Founden.Membership.url += 'memberships'
