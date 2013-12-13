# TaskList class serializer
class TaskListSerializer < AttachmentSerializer
  root :task_list

  attributes :tasks
end
