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

  scrollToLastMessage: ( ->
    Ember.run.schedule 'afterRender', @, ->
      $.scrollTo('max')
  ).observes('content.messages')

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
      @set('replyToMessage', message)
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
        attachments.forEach (attachment) ->
          attachment.set('message', message)
          attachment.set('conversation', conversation)
          attachment.set('user', user)
          attachment.save().then ->
            message.get('attachments').pushObject(attachment)

    messages.pushObject(message)

  addMessage: (content, attachments) ->
    @saveMessage(content, attachments)

  actions:

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

    addMember: (user) ->
      participants = @get('content.participants')
      if participants.indexOf(user) < 0
        membership = @store.createRecord 'membership',
          user: user
          conversation: @get('content')
        membership.save().then ->
          participants.pushObject(user)
