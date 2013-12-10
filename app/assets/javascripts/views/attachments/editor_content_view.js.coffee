Founden.AttachmentsEditorContentView = Ember.View.extend
  # Enable or disable the title
  needsTitle: false

  onInsertNewline: ->
    # Trigger tab to switch to message form
    $('[tabindex="1"]').focus()

  titleView: Ember.TextField.extend
    insertNewline: ->
      # Trigger tab to switch to `inputView`
      $('[tabindex="2"]').focus()

    didInsertElement: ->
      @$().focus()

  inputView: Ember.TextField.extend
    attributeBindings: ['tabIndex']
    tabIndex: 2
    insertNewlineBinding: 'parentView.onInsertNewline'

    didInsertElement: ->
      @$().focus()

    cancel: ->
      @get('parentView.controller').send('cancel')

  actions:
    enableTitle: ->
      @set('needsTitle', true)
