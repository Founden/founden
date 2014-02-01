Founden.ConversationsShowController = Ember.Controller.extend
  replyToMessage: null
  replyContent: null
  messageForm: null
  isReplying: false

  unreadCount: ( ->
    messages = @get('content.messages')
    if messages
      messages.filterProperty('isUnread', true).get('length')
  ).property('content.messages.@each.isUnread')

  parentMessages: ( ->
    @get('content.messages').filterProperty('parentMessage', null)
  ).property('content.messages.[]')

  latestMessages: ( ->
    parentMessages = @get('parentMessages')
    end = parentMessages.get('length')
    start = end - @get('content.latestOffset')
    start = 0 if start < 0
    parentMessages.slice(start, end)
  ).property('parentMessages', 'content.latestOffset')

  parentMessagesLeft: ( ->
    if @get('latestMessages.length') == @get('parentMessages.length')
      false
    else
      true
  ).property('latestMessages.length', 'parentMessages.length')

  scrollToMessage: (message, offset) ->
    Ember.run.scheduleOnce 'afterRender', @, ->
      if message
        $.scrollTo('.' + message.get('identifier'), 1000, {offset: offset || 50})
      else
        $.scrollTo('max')

  toggleNavbarOnReply: ( ->
    active = !!@get('replyToMessage')
    $('.navbar').toggleClass('narrow', active)
    $('.content').toggleClass('wide', active)
  ).observes('replyToMessage')

  focusOnMessage: (message) ->
    previousMessage = @get('replyToMessage')
    previousMessage.set('isFocused', false) if previousMessage
    if previousMessage == message
      @set('replyToMessage', null)
    else
      message.set('isFocused', true)
      @set('replyToMessage', message)

  saveMessage: (content, attachments) ->
    conversation = @get('content')
    messages = @get('content.messages')
    user = @get('currentUser')

    message = @store.createRecord 'message',
      content: content
      conversation: conversation
      user: user

    message.save().then =>
      if attachments
        attachments.forEach (attachment) =>
          attachment.set('message', message)
          attachment.set('conversation', conversation)
          attachment.set('user', user)
          attachment.save().then =>
            message.get('attachments').pushObject(attachment)
            @scrollToMessage(message, 700)

      @scrollToMessage(message)

    messages.pushObject(message)

  actions:
    incrementMessagesOffset: ->
      @incrementProperty('content.latestOffset', @get('content.offsetLimit'))

    addMessage: (content, attachments) ->
      @saveMessage(content, attachments)

    saveReply: ->
      conversation = @get('content')
      parentMessage = @get('replyToMessage')
      user = @get('currentUser')

      message = @store.createRecord 'message',
        content: @get('replyContent')
        conversation: conversation
        parentMessage: parentMessage
        user: user

      message.save().then =>
        @set('replyContent', null)
        parentMessage.get('replies').pushObject(message)
        @scrollToMessage(message, -50)

    addMember: (user) ->
      participants = @get('content.participants')
      if participants.indexOf(user) < 0
        membership = @store.createRecord 'membership',
          user: user
          conversation: @get('content')
        membership.save().then ->
          participants.pushObject(user)
