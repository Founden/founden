Founden.InvitationsShowController = Ember.Controller.extend
  actions:
    acceptInvitation: ->
      @get('content').save().then =>
        @transitionTo('conversations')
