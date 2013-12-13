Founden.ConversationsShowRoute = Ember.Route.extend
  deactivate: ->
    @currentModel.set('isUnread', false)
    messages = @currentModel.get('messages')
    messages.setEach('isUnread', false)

  actions:

    addToSummary: (message) ->
      message.toggleProperty('isSummary')

    activateReplyOn: (message) ->
      @controller.focusOnMessage(message)
