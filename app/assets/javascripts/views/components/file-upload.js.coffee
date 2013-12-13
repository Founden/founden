Founden.FileUploadComponent = Ember.Component.extend
  classNames: ['uploader']
  uploads: []

  doNothing: (event) ->
    event.preventDefault()
    false

  onDropOrChange: (event) ->
    input = event.dataTransfer || event.target
    if input.files and input.files.length > 0
      @get('parentView').handleFile(event, file) for file in input.files
    @doNothing(event)

  handleFile: (event, attachment) ->
    reader = new FileReader()
    reader.onload = (e) =>
      attachment.result = (e.target || e.srcResult).result
      if attachment.type == ''
        attachment.result = attachment.result.replace(
          'data:;base64,', 'data:application/octet-stream;base64,')
      @get('uploads').pushObject(attachment)
    reader.readAsDataURL(attachment)

  actions:
    removeUpload: (upload) ->
      @get('uploads').removeObject(upload)

  hiddenFileInputView: Ember.View.extend
    tagName: 'input'
    attributeBindings: ['type', 'name', 'multiple']
    type: 'file'
    name: 'image'
    multiple: true
    doNothingBinding: 'parentView.doNothing'
    changeBinding: 'parentView.onDropOrChange'

    didClicked: ( ->
      event = @get('parentView.isAttaching')
      @$().trigger('click', event)
    ).observes('parentView.isAttaching')

    didInsertElement: ->
      @$().click()

  dropAreaView: Ember.View.extend
    isDragging: false
    isVisible: true
    classNames: ['uploader-drop-area']
    classNameBindings: ['isDragging:hover']
    doNothingBinding: 'parentView.doNothing'
    dropBinding: 'parentView.onDropOrChange'

    click: (event) ->
      @set('parentView.isAttaching', event)
      @doNothing(event)

    dragOver: (event) ->
      @set('isDragging', true)
      @doNothing(event)

    dragEnter: (event) ->
      @set('isDragging', true)
      @doNothing(event)

    dragLeave: (event) ->
      @set('isDragging', false)
      @doNothing(event)
