# User network class
class Network < ActiveRecord::Base
  # Include support for obfuscated ID
  extend FriendlyId
  include ObfuscatedId

  # Obfuscates record ID
  friendly_id :obfuscated_id, :use => :slugged

  # store_accessor :data, :attr

  # Relationships
  belongs_to :user
  has_many :conversations
  has_many :messages

  # Validations
  validates_presence_of :title, :user
  validates_uniqueness_of :title, :scope => :user_id, :case_sensitive => false

  # Callbacks
  before_validation do
    self.title = Sanitize.clean(self.title)
  end
end
