Founden.ConversationsShowController = Ember.Controller.extend
  replyToMessage: null
  messageForm: null
  hasSummary: false
  isReplying: false

  unreadCount: ( ->
    messages = @get('content.messages')
    if messages
      messages.filterProperty('isUnread', true).get('length')
  ).property('content.messages.@each.isUnread')

  summaryMessages: ( ->
    messages = @get('content.messages')
    if messages
      messages.filterProperty('isSummary', true)
  ).property('content.messages.@each.isSummary')

  focusOnMessage: (message) ->
    previousMessage = @get('replyToMessage')
    previousMessage.set('isFocused', false) if previousMessage
    if previousMessage == message
      @set('replyToMessage', null)
    else
      @set('replyToMessage', message)
      message.set('isFocused', true)
      @set('replyToMessage', message)
      @get('messageForm.textarea').focus()

  saveMessage: (content, attachments) ->
    conversation = @get('content')
    network = @get('content.network')
    messages = @get('content.messages')
    user = @get('currentUser')

    message = @store.createRecord 'message',
      content: content
      network: network
      conversation: conversation
      user: user

    message.save().then ->
      if attachments
        attachments.forEach (attachment) ->
          attachment.set('message', message)
          attachment.set('conversation', conversation)
          attachment.set('network', network)
          attachment.set('user', user)
          attachment.save().then ->
            message.get('attachments').pushObject(attachment)

    messages.pushObject(message)

  saveReply: (content, attachments) ->
    conversation = @get('content')
    network = @get('content.network')
    parentMessage = @get('replyToMessage')
    user = @get('currentUser')

    message = @store.createRecord 'message',
      content: content
      network: network
      conversation: conversation
      parentMessage: parentMessage
      user: user

    message.save().then ->
      if attachments
        attachments.forEach (attachment) ->
          attachment.set('message', message)
          attachment.set('conversation', conversation)
          attachment.set('network', network)
          attachment.set('user', user)
          attachment.save().then ->
            message.get('attachments').pushObject(attachment)

    parentMessage.get('replies').pushObject(message)

  actions:

    addMessage: (content, attachments) ->
      @set('isReplying', false)
      # TODO: DRY these methods
      if @get('replyToMessage')
        @saveReply(content, attachments)
      else
        @saveMessage(content, attachments)
      # TODO: Scroll the page down

    addMember: (user) ->
      participants = @get('content.participants')
      if participants.indexOf(user) < 0
        membership = @store.createRecord 'membership',
          user: user
          network: @get('content.network')
          conversation: @get('content')
        membership.save().then ->
          participants.pushObject(user)

    startMention: ->
      # TODO: DRY this, probably move to mentions-support component
      textarea = @get('messageForm.textarea').get(0)
      textarea.value += '@'
      textarea.selectionEnd += 1 if textarea.selectionEnd
      @get('messageForm.mentionsSupport').onAtKeyPress(textarea)

    toggleSummary: ->
      @toggleProperty('hasSummary')
