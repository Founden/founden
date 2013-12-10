Founden.AttachmentsEditorContentController = Ember.ArrayController.extend
  # Content type to add to push upon initialization
  contentTypeKey: null

  # If there's no content, we create one
  contentDidChange: ( ->
    content = @get('content')
    if Ember.isEmpty(content)
      entry = @store.createRecord @get('contentTypeKey'),
        createdAt: new Date()
      content.pushObject(entry)
  ).observes('content.length')

  actions:
    cancel: ->
      @send('closeEditor')
