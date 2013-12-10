Founden.CaretCursorComponent = Ember.Component.extend Founden.TextAreaCaretMixin,
  classNames: ['caret']
  isVisible: false
  textareaBinding: 'parentView.textarea'
  mentionsSupportBinding: 'parentView.mentionsSupport'
  attachmentsSupportBinding: 'parentView.attachmentsSupport'

  isVisibleObserver: ( ->
    if @get('mentionsSupport.isVisible') or @get('attachmentsSupport.isVisible')
      @set('isVisible', false)
  ).observes('mentionsSupport.isVisible', 'attachmentsSupport.isVisible')

  caretChanged: ( ->
    @$().css
      top: @get('caret.top')
      left: @get('caret.left')
  ).observes('caret.top', 'caret.left')

  mentionView: Ember.View.extend
    tagName: 'span'
    click: ->
      textarea = @get('parentView.textarea').get(0)
      textarea.value += '@'
      textarea.selectionEnd += 1 if textarea.selectionEnd
      @get('parentView.mentionsSupport').onAtKeyPress(textarea)

  attachmentView: Ember.View.extend
    tagName: 'span'
    click: ->
      textarea = @get('parentView.textarea').get(0)
      textarea.value += ' '
      textarea.selectionEnd += 1 if textarea.selectionEnd
      @get('parentView.attachmentsSupport').onPlusKeyPress(textarea)
