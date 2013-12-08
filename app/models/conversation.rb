# Conversation class
class Conversation < ActiveRecord::Base
  # Include support for obfuscated ID
  include ObfuscatedId

  # store_accessor :data, :key

  # Relationships
  belongs_to :user
  belongs_to :network
  has_many :messages
  has_many :attachments

  # Validations
  validates_presence_of :title, :user, :network
  validates_uniqueness_of :slug

  # Callbacks
  before_validation do
    self.title = Sanitize.clean(self.title)
  end
end
