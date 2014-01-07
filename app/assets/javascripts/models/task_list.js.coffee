Founden.TaskList = Founden.Attachment.extend
  isTaskList: true
  tasks: Ember.attr('tasks', defaultValue: Ember.ArrayProxy.create(content: []))

Founden.TaskList.rootKey = 'task_list'
