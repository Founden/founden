Founden.AttachmentsLinkEmbedController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'link'
  # Since content is an array, we bind to the first object
  linkBinding: 'content.firstObject'
