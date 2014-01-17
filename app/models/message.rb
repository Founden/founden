# Message class
class Message < ActiveRecord::Base
  # Include support for obfuscated ID
  include ObfuscatedId
  # Include support for notifications
  include Notifier

  # store_accessor :data, :attr

  # Default scope: order by creation date
  default_scope { order(:created_at => :asc) }

  # Relationship
  belongs_to :user
  belongs_to :conversation
  belongs_to :summary
  belongs_to :parent_message, :class_name => Message
  has_many :attachments, :dependent => :destroy
  has_many :replies, :class_name => Message,
    :dependent => :destroy, :foreign_key => :parent_message_id

  # Validations
  validates_presence_of :content, :user, :conversation
  validates_uniqueness_of :slug

  # Callbacks
  before_validation do
    self.content = Sanitize.clean(self.content)
  end
  # Use around since we need to process mentions before saving
  # and enqueue email jobs after saving the entry
  around_create :materialize_mentions

  private

  # Overwrites `Notifier#notification_channels`
  def notification_channels
    if self.conversation
      self.conversation.participant_ids.map { |pid| 'user_%d' % pid }
    else
      super
    end
  end

  # Replaces participant names with ampersate and their IDs.
  def materialize_mentions
    yield and return true unless self.conversation

    # Process mentions
    mentions = []
    members = self.conversation.participants.pluck(*%i{id first_name last_name})
    members.each do |user|
      name = user[1..2].join(' ')
      if self.content.include?(name)
        token = '@id:%d@' % user[0]
        content.sub!(name, token)
        mentions << user[0]
      end
    end

    yield

    # Process email jobs to anyone mentioned
    mentions.each { |mention_user_id| notify_mention(mention_user_id) }
    return true
  end

  # Sends a notification email to mentioned user
  def notify_mention(user_id)
    QC.enqueue('UserMailer.deliver', :mention, self.id, user_id)
  end
end
