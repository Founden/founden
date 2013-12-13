Founden.MessageFormComponent = Ember.Component.extend Founden.ScrollEventsMixin,
  classNames: ['message-form']
  classNameBindings: ['isActive:focus']
  isActive: false
  showCaret: false
  keyPressEvent: false
  selectedAttachmentType: null
  messageContent: ''
  textarea: null
  mentionsSupport: null
  attachmentsSupport: null
  # The controller action mapping. I know right?!
  sendMessage: 'addMessage'
  # This one is needed if we want to add a member from a sub-component
  addMember: 'addMember'

  onScroll: ->
    @set('isActive', false)
    @set('showCaret', false)

  showCaretObserver: ( ->
    if @get('mentionsSupport.isVisible') == true or @get('attachmentsSupport.isVisible') == true
      @set('showCaret', false)
  ).observes('mentionsSupport.isVisible', 'attachmentsSupport.isVisible')

  networkMembers: ( ->
    @get('targetObject.store').find('user').then (users) =>
      @set('networkMembers', users.rejectBy('name', @get('user.name')))
  ).property('user')

  handleMessage: ->
    content = @get('messageContent')
    if content.length > 1
      attachments = @get('selectedAttachmentType.attachments')
      @sendAction('sendMessage', content, attachments)
      @set('selectedAttachmentType', null)
      @set('messageContent', '')

  messageView: Ember.TextArea.extend
    classNames: ['message-form-input']
    attributeBindings: ['tabIndex']
    tabIndex: 1
    valueBinding: 'parentView.messageContent'

    didInsertElement: ->
      @set('parentView.textarea', @$())

    focusIn: (event) ->
      @set('parentView.isActive', true)
      @set('parentView.showCaret', true)

    keyUp: (event) ->
      @set('parentView.keyPressEvent', event)
      @set('parentView.isActive', true)
      @set('parentView.showCaret', true)

    insertNewline: (event) ->
      if event.ctrlKey
        @get('parentView').handleMessage()

    cancel:(event) ->
      # TODO: catch esc key first in keyUp
      @set('parentView.isActive', false)
      @set('parentView.showCaret', false)

  didInsertElement: ->
    @_super()
    @set('messageForm', @)
    # Activate `onScroll` event
    @registerOnScroll()

  actions:
    submit: ->
      @handleMessage()
