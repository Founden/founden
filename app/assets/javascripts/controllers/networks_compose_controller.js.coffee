Founden.NetworksComposeController = Ember.Controller.extend

  actions:

    create: ->
      conversation = @get('content')
      conversation.save().then =>
        @transitionToRoute('conversations.show', conversation)
