Founden.AttachmentsEditorContentController = Ember.ArrayController.extend
  # Content type to add to push upon initialization
  contentTypeKey: null

  # If there's no content, we create one
  init: ->
    @_super()

    content = @get('content')
    if Ember.isEmpty(content) and typeKey = @get('contentTypeKey')
      content.pushObject @store.createRecord(typeKey)

  actions:
    cancel: ->
      @send('closeEditor')
