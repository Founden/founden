# Application user class
class User < ActiveRecord::Base
  # Include support for authentication
  include EasyAuth::Models::Account
  # Include support for obfuscated ID
  include ObfuscatedId

  store_accessor :data, :promo_code

  # Relationships
  has_many :identities, :dependent => :destroy, :foreign_key => :account_id

  has_many :created_networks, :class_name => Network
  has_many :network_memberships, :dependent => :destroy
  has_many :shared_networks, :through => :network_memberships
  has_many :memberships, :dependent => :destroy
  has_many :networks, proc { distinct }, :through => :memberships

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
  after_create do
    self.created_networks.create(:title => _('%s Network') % self.full_name)
  end

  # Returns user full name
  def full_name
    [self.first_name, self.last_name].join(' ')
  end
end
