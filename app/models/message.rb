# Message class
class Message < ActiveRecord::Base
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
  belongs_to :summary
  has_many :attachments, :dependent => :destroy

  # Validations
  validates_presence_of :content, :user, :network, :conversation

  # Callbacks
  before_validation do
    self.content = Sanitize.clean(self.content)
  end
end
