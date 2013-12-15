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

  has_many :conversation_memberships, :dependent => :destroy
  has_many :participants,
    :through => :conversation_memberships, :source => :user

  # Validations
  validates_presence_of :title, :user, :network
  validates_uniqueness_of :slug

  # Callbacks
  before_validation do
    self.title = Sanitize.clean(self.title)
  end
  after_create do
    self.conversation_memberships.create(
      :creator => self.user, :user => self.user, :network => self.network)
  end
end
