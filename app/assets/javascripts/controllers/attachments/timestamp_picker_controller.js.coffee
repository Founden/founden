Founden.AttachmentsTimestampPickerController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'timestamp'
  # Since content is an array, we bind to the first object
  timestampBinding: 'content.firstObject'
