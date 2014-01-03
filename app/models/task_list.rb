# Message task list attachment class
class TaskList < Attachment
  # Store tasks with hstore
  store_accessor :data, :tasks

  # Validations
  validates_presence_of :user, :message, :tasks

  # Callbacks
  after_initialize do
    self.tasks ||= []
  end
  before_validation do
    self.tasks = [] unless self.tasks.is_a?(Array)
    self.tasks = self.tasks.each_with_index do |task, index|
      if task.is_a?(Hash) and label = Sanitize.clean(task['label'])
        task['label'] = label
        task['checked'] = !!task['checked']
      end
    end
    self.tasks.reject!{ |task| !task.is_a?(Hash) }
  end
  # Custom serialization hooks to avoid double `to_s` since we are using hstore
  after_save :decode_tasks
  before_save :encode_tasks
  after_find :decode_tasks

  private

    # Callback to decode `tasks` from a JSON string
    def decode_tasks
      if self.tasks.is_a?(String)
        self.tasks = ActiveSupport::JSON.decode(self.tasks) rescue self.tasks
      end
    end

    # Callback to encode `tasks` to a JSON
    def encode_tasks
      self.tasks =
        ActiveSupport::JSON.encode(self.tasks) rescue self.tasks.to_json
    end
end
