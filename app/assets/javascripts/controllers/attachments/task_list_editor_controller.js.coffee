Founden.AttachmentsTaskListEditorController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'TaskList'
  newTask: null
  allowsTasksRemoval: true

  # Wrap taskList to first object in content
  taskList: ( ->
    @get('content.firstObject')
  ).property('content.firstObject')

  actions:
    addTask: ->
      taskName = @get('newTask')
      if taskName and taskName.length > 0
        @get('taskList.tasks').pushObject Ember.Object.create
          label: taskName, checked: false
        @set('newTask', null)

    removeTask: (task) ->
      @get('taskList.tasks').removeObject(task)
