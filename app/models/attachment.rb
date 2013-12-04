# Message attachment class
class Attachment < ActiveRecord::Base
  # Include support for obfuscated ID
  extend FriendlyId
  include ObfuscatedId

  # Obfuscates record ID
  friendly_id :obfuscated_id, :use => :slugged

  # store_accessor :data, :attr

  # Relationship
  belongs_to :user
  belongs_to :network
  belongs_to :conversation
  belongs_to :message
  belongs_to :summary

  # Callbacks
  before_validation do
    self.title = Sanitize.clean(self.title)
  end
end
