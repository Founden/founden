Founden.Invitation = Ember.Model.extend Founden.TimeAgoMixin,
  email: Ember.attr()
  networkTitle: Ember.attr(readOnly: true)
  createdAt: Ember.attr('date', readOnly: true, defaultValue: new Date)

  user: Ember.belongsTo('user')
  network: Ember.belongsTo('network')
  membership: Ember.belongsTo('membership')

Founden.Invitation.rootKey = 'invitation'
Founden.Invitation.collectionKey = 'invitations'
Founden.Invitation.url += 'invitations'
