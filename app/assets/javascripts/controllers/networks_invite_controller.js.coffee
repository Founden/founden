Founden.NetworksInviteController = Ember.Controller.extend
  email: null

  actions:
    sendInvitation: ->
      invitation = @store.createRecord 'invitation',
        network: @get('content')
        email: @get('email')
      invitation.save().then =>
        @set('email', null)
