# TaskList class serializer
class TaskListSerializer < AttachmentSerializer
  root :taskList

  attributes :tasks
end
