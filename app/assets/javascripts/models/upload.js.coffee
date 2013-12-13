Founden.Upload = Founden.Attachment.extend
  isUpload: true
  previewUrl: DS.attr('string', readOnly: true)
  attachment: DS.attr('string')
  attachmentSize: DS.attr('number', readOnly: true)
