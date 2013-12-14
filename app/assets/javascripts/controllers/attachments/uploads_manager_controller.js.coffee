Founden.AttachmentsUploadsManagerController = Ember.ArrayController.extend
  uploads: []

  uploadsDidChange: ( ->
    uploads = @get('uploads')
    content = @get('content')

    if uploads and uploads.get('length') > 0
      while upload = uploads.pop()
        if (/image/).test(upload.type)
          upload.preview = upload.result

        upload = @store.createRecord 'upload',
          title: upload.name
          previewUrl: upload.preview
          attachment: upload.result
          attachmentFileSize: upload.size

        content.pushObject(upload)
  ).observes('uploads.length')

  actions:
    removeUpload: (upload) ->
      @get('content').removeObject(upload)
