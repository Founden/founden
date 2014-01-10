Founden.ConversationsIndexRoute = Ember.Route.extend
  setupController: (controller, model) ->
    controller.set('content', @currentUser.get('conversations'))

Founden.ConversationsShowRoute = Ember.Route.extend
  deactivate: ->
    @currentModel.set('isUnread', false)
    messages = @currentModel.get('messages')
    messages.setEach('isUnread', false)

  actions:

    addToSummary: (message) ->
      message.set('summaryId', !message.get('summaryId'))
      message.save()

    activateReplyOn: (message) ->
      @controller.focusOnMessage(message)

    toggleSummary: ->
      @controller.get('content.summary').reload()
      @controller.toggleProperty('hasSummary')
