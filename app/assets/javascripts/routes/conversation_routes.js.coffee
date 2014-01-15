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
      message.save()

    activateReplyOn: (message) ->
      @controller.focusOnMessage(message)

    toggleSummary: ->
      @controller.toggleProperty('hasSummary')

Founden.ConversationsNewRoute = Ember.Route.extend
  model: ->
    @store.createRecord 'conversation'
