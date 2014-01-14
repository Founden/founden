Founden.ConversationsNewController = Ember.Controller.extend
  actions:
    create: ->
      console.log @get('content.title')
      conversation = @get('content')
      conversation.save().then =>
        @transitionTo('conversations.show', conversation)
