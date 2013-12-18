Founden.InvitationsShowController = Ember.Controller.extend
  actions:
    acceptInvitation: ->
      @get('content').save().then (invitation) =>
        @get('currentUser').reload()
        network_id = invitation.get('membership.network.id')
        @transitionToRoute('networks.show', network_id)
