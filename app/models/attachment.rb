# Message attachment class
class Attachment < ActiveRecord::Base
  # Include support for obfuscated ID
  include ObfuscatedId

  # store_accessor :data, :attr

  # Relationship
  belongs_to :user
  belongs_to :conversation
  belongs_to :message
  belongs_to :summary

  # Validations
  validates_uniqueness_of :slug

  # Callbacks
  before_validation do
    self.title = Sanitize.clean(self.title)
  end
end
