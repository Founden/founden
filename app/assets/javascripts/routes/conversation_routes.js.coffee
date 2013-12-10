Founden.ConversationsShowRoute = Ember.Route.extend
  afterModel: (model) ->
    model.set('isUnread', false)

  deactivate: ->
    @currentModel.get('messages').then (messages) ->
      messages.setEach('isUnread', false)

  actions:

    addToSummary: (message) ->
      message.toggleProperty('isSummary')

    activateReplyOn: (message) ->
      @controller.focusOnMessage(message)
