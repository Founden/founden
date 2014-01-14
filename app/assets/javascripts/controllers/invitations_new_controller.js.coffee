Founden.InvitationsNewController = Ember.Controller.extend
  actions:
    sendInvitation: ->
      @get('content').save().then =>
        @transitionToRoute('conversations')
