Founden.NetworksInviteController = Ember.Controller.extend
  email: null

  actions:
    sendInvitation: ->
      invitation = @container.resolve('model:invitation').create
        network: @get('content')
        email: @get('email')
      invitation.save().then =>
        @set('email', null)
