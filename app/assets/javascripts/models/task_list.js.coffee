Founden.TaskList = Founden.Attachment.extend
  isTaskList: true
  tasks: DS.attr('tasks', defaultValue: Ember.ArrayProxy.create(content: []))
