Founden.AttachmentsTimestampPickerController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'timestamp'
  # Wrap timestamp to first object in content
  timestamp: ( ->
    @get('content.firstObject')
  ).property('content.firstObject')
