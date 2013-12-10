Founden.ConversationsShowController = Ember.Controller.extend
  replyToMessage: null
  messageForm: null
  hasSummary: false
  isReplying: false

  unreadCount: ( ->
    @get('content.messages').filterProperty('isUnread', true).get('length')
  ).property('content.messages.@each.isUnread')

  summaryMessages: ( ->
    @get('content.messages').filterProperty('isSummary', true)
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
    messages = @get('content.messages')

    attachments ||= []
    payload = attachments.map (attachment) ->
      {id: attachment.id, type: attachment.constructor.typeKey}

    # TODO: Fix this shit after we replace `FixtureAdapter`
    message = @store.createRecord 'message',
      content: content
      createdAt: (new Date()).toString()

    @store.push 'message',
      id: message.get('id')
      attachments: payload
      user: @get('currentUser.id')

    messages.pushObject(message)

  saveReply: (content, attachments) ->
    parentMessage = @get('replyToMessage')

    attachments ||= []
    payload = attachments.map (attachment) ->
      {id: attachment.id, type: attachment.constructor.typeKey}

    # TODO: Fix this shit after we replace `FixtureAdapter`
    message = @store.createRecord 'message',
      content: content
      createdAt: (new Date()).toString()

    @store.push 'message',
      id: message.get('id')
      attachments: payload
      user: @get('currentUser.id')
      parentMessage: parentMessage.get('id')

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
      people = @get('content.people')
      if people.indexOf(user) < 0
        people.pushObject(user)

    startMention: ->
      # TODO: DRY this, probably move to mentions-support component
      textarea = @get('messageForm.textarea').get(0)
      textarea.value += '@'
      textarea.selectionEnd += 1 if textarea.selectionEnd
      @get('messageForm.mentionsSupport').onAtKeyPress(textarea)

    toggleSummary: ->
      @toggleProperty('hasSummary')
