Founden.NetworksShowController = Ember.Controller.extend
  inboxLimit: 4
  ongoingLimit: 4

  inbox: ( ->
    if inbox = @get('content.inbox')
      inbox.slice(0, @get('inboxLimit'))
  ).property('content.inbox.length', 'inboxLimit')

  ongoing: ( ->
    if ongoing = @get('content.ongoing')
      ongoing.slice(0, @get('ongoingLimit'))
  ).property('content.ongoing.length', 'ongoingLimit')

  inboxLimitReached: ( ->
    @get('content.inbox.length') < @get('inboxLimit')
  ).property('inboxLimit', 'content.inbox.length')

  ongoingLimitReached: ( ->
    @get('content.ongoing.length') < @get('ongoingLimit')
  ).property('ongoingLimit', 'content.ongoing.length')
