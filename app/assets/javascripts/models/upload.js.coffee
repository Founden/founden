Founden.Upload = Founden.Attachment.extend
  isUpload: true
  attachment: DS.attr('string')
  # Figure out why this is not working
  smallSizeUrl: DS.attr('string')
  attachmentFileSize: DS.attr('number', readOnly: true)
  attachmentFileName: DS.attr('string', readOnly: true)

  previewUrl: ( ->
    @get('attachment')
  ).property('attachment')
