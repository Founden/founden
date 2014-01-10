Founden.AttachmentsLinkEmbedController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'link'
  # Wrap link to first object in content
  link: ( ->
    @get('content.firstObject')
  ).property('content.firstObject')
