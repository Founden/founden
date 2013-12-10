Founden.AttachmentsTaskListEditorView = Founden.AttachmentsEditorContentView.extend
  newlinesCount: 0

  # Overwrites `AttachmentsEditorContentView` method
  onInsertNewline: ->
    newlinesCount = @get('parentView.newlinesCount')
    if @get('value').length < 1 and newlinesCount < 2
      @incrementProperty('parentView.newlinesCount')
      # Trigger tab to switch to message form
      $('[tabindex="1"]').focus() if newlinesCount == 1
    else
      @set('parentView.newlinesCount', 0)
      @sendAction('enter')
