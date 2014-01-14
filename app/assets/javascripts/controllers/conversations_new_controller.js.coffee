Founden.ConversationsNewController = Ember.Controller.extend
  actions:
    create: ->
      conversation = @get('content')
      conversation.save().then =>
        @transitionTo('conversations.show', conversation)
