# Application user class
class User < ActiveRecord::Base
  # Include support for authentication
  include EasyAuth::Models::Account
  # Include support for obfuscated ID
  include ObfuscatedId
  # Include support for notifications
  include Listener

  store_accessor :data, :promo_code

  # Relationships
  has_many :identities, :dependent => :destroy, :foreign_key => :account_id

  has_many :memberships, :dependent => :destroy

  has_many :created_friendships, :dependent => :destroy,
    :foreign_key => :creator_id, :class_name => Friendship
  has_many :added_contacts, :through => :created_friendships, :source => :user
  has_many :friendships, :dependent => :destroy
  has_many :mutual_contacts, :through => :friendships, :source => :creator

  has_many :created_conversations, :class_name => Conversation
  has_many :conversation_memberships, :dependent => :destroy
  has_many :conversations, :through => :conversation_memberships

  has_many :messages
  has_many :attachments
  has_one :avatar, :dependent => :destroy
  has_many :invitations, :dependent => :destroy

  # Validations
  validates :email, :uniqueness => true, :presence => true
  validates_uniqueness_of :slug

  # Callbacks

  # Returns user full name
  def full_name
    [self.first_name, self.last_name].join(' ')
  end
end
