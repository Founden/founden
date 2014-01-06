Founden.Upload = Founden.Attachment.extend
  isUpload: true
  attachment: Ember.attr()
  thumbSizeUrl: Ember.attr(readOnly: true)
  smallSizeUrl: Ember.attr(readOnly: true)
  mediumSizeUrl: Ember.attr(readOnly: true)
  attachmentFileSize: Ember.attr('number', readOnly: true)
  attachmentFileName: Ember.attr(readOnly: true)

  previewUrl: ( ->
    @get('smallSizeUrl')
  ).property('smallSizeUrl')

Founden.Upload.rootKey = 'upload'
