# Message timestamp attachment class
class Timestamp < Attachment
  # Store timestamp with hstore
  store_accessor :data, :timestamp

  # Validations
  validates_presence_of :user, :message, :timestamp

  # Callbacks
  before_validation do
    self.timestamp = DateTime.parse(self.timestamp).to_s rescue nil
  end
end
