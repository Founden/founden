Founden.InvitationsShowController = Ember.Controller.extend
  actions:
    acceptInvitation: ->
      @get('content').save().then =>
        @transitionToRoute('conversations')
