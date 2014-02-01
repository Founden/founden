Founden.ConversationsIndexRoute = Ember.Route.extend
  model: ->
    @currentUser.get('conversations')

Founden.ConversationsShowRoute = Ember.Route.extend
  deactivate: ->
    @currentModel.set('isUnread', false)
    messages = @currentModel.get('messages')
    messages.setEach('isUnread', false)

  actions:

    addToSummary: (message) ->
      message.set('summaryId', !message.get('summaryId'))
      if summary = message.get('conversation.summary')
        message.save().then ->
          summary.reload()
      else
        message.save().then ->
          message.get('conversation').reload()

    activateReplyOn: (message) ->
      @controller.focusOnMessage(message)

Founden.ConversationsNewRoute = Ember.Route.extend
  model: ->
    @store.createRecord 'conversation'
