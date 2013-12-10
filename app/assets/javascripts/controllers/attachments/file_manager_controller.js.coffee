Founden.AttachmentsFileManagerController = Ember.ArrayController.extend
  uploads: []

  uploadsDidChange: ( ->
    uploads = @get('uploads')
    content = @get('content')

    if uploads and uploads.get('length') > 0
      while upload = uploads.pop()
        if (/image/).test(upload.type)
          upload.preview = upload.result

        file = @store.createRecord 'file',
          title: upload.name
          previewUrl: upload.preview
          attachment: upload.result
          attachmentSize: upload.size

        content.pushObject(file)
  ).observes('uploads.length')

  actions:
    removeFile: (file) ->
      @get('content').removeObject(file)
