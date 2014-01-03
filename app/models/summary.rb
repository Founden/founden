# Summary class
class Summary < ActiveRecord::Base
  # Include support for obfuscated ID
  include ObfuscatedId

  # store_accessor :data, :key

  # Relationships
  belongs_to :conversation
  has_many :messages

  # Validations
  validates_presence_of :conversation
  validates_uniqueness_of :slug

  # Callbacks
  before_validation do
    self.title = Sanitize.clean(self.title)
  end
end
