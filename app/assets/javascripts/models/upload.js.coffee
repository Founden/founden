Founden.Upload = Founden.Attachment.extend
  isUpload: true
  attachment: DS.attr('string')
  thumbSizeUrl: DS.attr('string', readOnly: true)
  smallSizeUrl: DS.attr('string', readOnly: true)
  mediumSizeUrl: DS.attr('string', readOnly: true)
  attachmentFileSize: DS.attr('number', readOnly: true)
  attachmentFileName: DS.attr('string', readOnly: true)

  previewUrl: ( ->
    @get('smallSizeUrl')
  ).property('smallSizeUrl')
