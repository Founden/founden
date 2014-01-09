Founden.AttachmentsEditorContentController = Ember.ArrayController.extend
  # Content type to add to push upon initialization
  contentTypeKey: null

  # If there's no content, we create one
  init: ->
    @_super()
    content = @get('content')
    type = @get('contentTypeKey')

    if Ember.isEmpty(content)
      entry = @container.resolve('model:' + type).create
        createdAt: new Date()
      content.pushObject(entry)

  actions:
    cancel: ->
      @send('closeEditor')
