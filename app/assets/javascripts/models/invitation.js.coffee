Founden.Invitation = Ember.Model.extend Founden.TimeAgoMixin,
  email: Ember.attr()
  createdAt: Ember.attr('date', readOnly: true, defaultValue: new Date)

  user: Ember.belongsTo('user', key: 'user_id', readOnly: true)
  membership: Ember.belongsTo('membership', key: 'membership_id', readOnly: true)

Founden.Invitation.rootKey = 'invitation'
Founden.Invitation.collectionKey = 'invitations'
Founden.Invitation.url += 'invitations'
