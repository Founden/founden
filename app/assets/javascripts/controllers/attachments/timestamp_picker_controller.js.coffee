Founden.AttachmentsTimestampPickerController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'timestamp'

  # Map timestamp attribute to first object
  timestamp: ( ->
    @get('content.firstObject')
  ).property('content.firstObject')
