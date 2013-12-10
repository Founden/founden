Founden.TasksTransform = DS.Transform.extend
  taskClass: Ember.Object.extend
    list: null
    label: null
    checked: null
    onChangeObserver: ( ->
      if list = @get('list')
        list.contentArrayDidChange()
    ).observes('label', 'checked')

  serialize: (list) ->
    tasks = []
    list.forEach (task) ->
      tasks.push task.getProperties('label', 'checked')
    tasks

  deserialize: (tasks) ->
    list = Ember.ArrayProxy.create(content: [])
    if Ember.isArray(tasks)
      tasks.forEach (taskPayload) =>
        task = @taskClass.create(taskPayload)
        task.set('list', list)
        list.addObject task
    list
