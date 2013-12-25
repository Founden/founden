# Message class
class Message < ActiveRecord::Base
  # Include support for obfuscated ID
  include ObfuscatedId
  # Include support for notifications
  include Notifier

  # store_accessor :data, :attr

  # Relationship
  belongs_to :user
  belongs_to :network
  belongs_to :conversation
  belongs_to :summary
  belongs_to :parent_message, :class_name => Message
  has_many :attachments, :dependent => :destroy
  has_many :replies, :class_name => Message,
    :dependent => :destroy, :foreign_key => :parent_message_id

  # Validations
  validates_presence_of :content, :user, :network, :conversation
  validates_uniqueness_of :slug

  # Callbacks
  before_validation do
    self.content = Sanitize.clean(self.content)
  end

  private

  # Overwrites `Notifier#notification_channels`
  def notification_channels
    if self.conversation
      self.conversation.participants.map { |part| 'user_%d' % part.id }
    else
      super
    end
  end
end
