Founden.AttachmentsLocationSearchController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'location'

  # Map location attribute to first object
  location: ( ->
    @get('content.firstObject')
  ).property('content.firstObject')
