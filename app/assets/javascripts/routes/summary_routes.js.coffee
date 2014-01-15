Founden.SummariesIndexRoute = Ember.Route.extend
  model: ->
    @currentUser.get('summaries')

Founden.SummariesShowRoute = Ember.Route.extend
  actions:
    activateReplyOn: (message) ->
      @controller.focusOnMessage(message)
