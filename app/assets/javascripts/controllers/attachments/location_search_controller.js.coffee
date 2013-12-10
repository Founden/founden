Founden.AttachmentsLocationSearchController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'location'
  # Since content is an array, we bind to the first object
  locationBinding: 'content.firstObject'
