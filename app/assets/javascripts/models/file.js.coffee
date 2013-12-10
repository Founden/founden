Founden.File = Founden.Attachment.extend
  isFile: true
  previewUrl: DS.attr('string')
  attachment: DS.attr('string')
  attachmentSize: DS.attr('number')
