Founden.AttachmentsSupportComponent = Ember.Component.extend Founden.TextAreaCaretMixin,
  classNames: ['attachment-options']
  isVisible: false

  search: ''
  selectedIndex: 0
  textarea: null
  selectedAttachmentType: null
  attachmentTypes: [
    Founden.AttachmentType.create(name: 'upload', isUpload: true)
    Founden.AttachmentType.create(name: 'tasklist', isTaskList: true)
    Founden.AttachmentType.create(name: 'link', isLink: true)
    Founden.AttachmentType.create(name: 'location', isLocation: true)
    Founden.AttachmentType.create(name: 'timestamp', isTimestamp: true)
  ]

  # Overwrites KeyboardEventsMixin hook
  onPlusKeyPress: (textarea) ->
    @set('textarea', textarea)
    @set('isVisible', true)

  searchView: Ember.TextField.extend Founden.FuzzySearchMixin,
    # Overwrites FuzzySearchMixin hook
    onInsertNewline: ->
      type = @get('parentView.content').objectAt(@get('parentView.selectedIndex'))
      @get('parentView').handleAttachment(type)
      @set('parentView.isVisible', false)

    # Overwrites FuzzySearchMixin hook
    onArrowUp: ->
      if @get('parentView.selectedIndex') > 0
        @decrementProperty('parentView.selectedIndex')
        true

    # Overwrites FuzzySearchMixin hook
    onArrowDown: ->
      index = @get('parentView.selectedIndex')
      contentLength = @get('parentView.content.length') - 1
      if index < contentLength
        @incrementProperty('parentView.selectedIndex')
        true

  optionView: Ember.View.extend
    option: null
    tagName: 'li'
    classNameBindings: 'option.isSelected:active'

    click: ->
      @get('parentView').handleAttachment(@get('option'))

  handleAttachment: (type) ->
    # Reset any previous attachments
    type.set('attachments', [])
    @set('selectedAttachmentType', type)
    textarea = @get('textarea')
    @appendAfterCarret(textarea, '')
    @set('isVisible', false)

  searchChanged: ( ->
    search = @get('search')
    types = @get('attachmentTypes')
    @set('selectedIndex', 0)

    if search and types and types.get('length') > 0
      searchRegexp = new RegExp(search, 'i')
      content = types.filter (type) ->
        # TODO: Add a new attribute with more semantic keywords
        searchRegexp.test type.get('name')
      @set('content', content)
    else
      @set('content', types)
  ).observes('search', 'attachmentTypes', 'isVisible')

  selectedIndexChanged: ( ->
    index = @get('selectedIndex')
    content = @get('content')

    return if index < 0

    task = content.objectAt(index)
    if task
      content.setEach('isSelected', false)
      task.set('isSelected', true)
  ).observes('selectedIndex', 'content')

  caretChanged: ( ->
    @$().css
      top: @get('caret.top')
      left: @get('caret.left')
  ).observes('caret.top', 'caret.left')

  becameHidden: ->
    @set('search', null)
    # Trigger tab to switch to parent input
    $('[tabindex="1"]').focus()

  didInsertElement: ->
    @set('parentView.attachmentsSupport', @)
