Founden.AttachmentsEditorComponent = Ember.Component.extend
  selectedType: null

  actions:
    closeEditor: ->
      @set('selectedType', null)
      # Trigger tab to switch to message form
      $('[tabindex="1"]').focus()
