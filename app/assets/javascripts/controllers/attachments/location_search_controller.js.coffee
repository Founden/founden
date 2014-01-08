Founden.AttachmentsLocationSearchController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'location'

  # Wrap location to first object in content
  location: ( ->
    @get('content.firstObject')
  ).property('content.firstObject')
