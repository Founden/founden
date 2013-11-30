# Conversation class
class Conversation < ActiveRecord::Base

  # Include support for obfuscated ID
  extend FriendlyId
  include ObfuscatedId

  # Obfuscates record ID
  friendly_id :obfuscated_id, :use => :slugged

  # store_accessor :data, :key

  # Relationships
  belongs_to :user
  belongs_to :network
  has_many :messages

  # Validations
  validates_presence_of :title, :user, :network

  # Callbacks
  before_validation do
    self.title = Sanitize.clean(self.title)
  end
end
