Founden.NetworksShowController = Ember.Controller.extend
  inboxLimit: 4
  ongoingLimit: 4

  inbox: ( ->
    if inbox = @get('content.conversations')
      inbox.slice(0, @get('inboxLimit'))
  ).property('content.conversations.length', 'inboxLimit')

  ongoing: ( ->
    if ongoing = @get('content.conversations')
      ongoing.slice(0, @get('ongoingLimit'))
  ).property('content.conversations.length', 'ongoingLimit')

  inboxLimitReached: ( ->
    @get('content.conversations.length') < @get('inboxLimit')
  ).property('inboxLimit', 'content.conversations.length')

  ongoingLimitReached: ( ->
    @get('content.conversations.length') < @get('ongoingLimit')
  ).property('ongoingLimit', 'content.conversations.length')
