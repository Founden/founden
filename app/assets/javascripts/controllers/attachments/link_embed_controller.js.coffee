Founden.AttachmentsLinkEmbedController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'link'

  # Map link attribute to first object
  link: ( ->
    @get('content.firstObject')
  ).property('content.firstObject')
