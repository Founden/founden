Founden.ConversationsShowController = Ember.Controller.extend
  replyToMessage: null
  messageForm: null
  isReplying: false

  unreadCount: ( ->
    messages = @get('content.messages')
    if messages
      messages.filterProperty('isUnread', true).get('length')
  ).property('content.messages.@each.isUnread')

  scrollToBottom: ->
    $('body, html').animate
      scrollTop: $(document).height()
    , 400

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
    messages = @get('content.messages')
    user = @get('currentUser')

    message = @store.createRecord 'message',
      content: content
      conversation: conversation
      user: user

    message.save().then =>
      @scrollToBottom()
      if attachments
        attachments.forEach (attachment) ->
          attachment.set('message', message)
          attachment.set('conversation', conversation)
          attachment.set('user', user)
          attachment.save().then ->
            message.get('attachments').pushObject(attachment)

    messages.pushObject(message)

  saveReply: (content, attachments) ->
    conversation = @get('content')
    parentMessage = @get('replyToMessage')
    user = @get('currentUser')

    message = @store.createRecord 'message',
      content: content
      conversation: conversation
      parentMessage: parentMessage
      user: user

    message.save().then =>
      @scrollToBottom()
      if attachments
        attachments.forEach (attachment) ->
          attachment.set('message', message)
          attachment.set('conversation', conversation)
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
          conversation: @get('content')
        membership.save().then ->
          participants.pushObject(user)
