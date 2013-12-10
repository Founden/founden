Founden.AttachmentsTaskListEditorController = Founden.AttachmentsEditorContentController.extend
  # Overwrites `AttachmentsEditorContentController` attribute
  contentTypeKey: 'TaskList'
  # Since content is an array, we bind to the first object
  taskListBinding: 'content.firstObject'
  newTask: null
  allowsTasksRemoval: true

  actions:
    addTask: ->
      taskName = @get('newTask')
      if taskName and taskName.length > 0
        @get('taskList.tasks').pushObject Ember.Object.create
          label: taskName, checked: false
        @set('newTask', null)

    removeTask: (task) ->
      @get('taskList.tasks').removeObject(task)
