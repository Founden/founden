# Application user class
class User < ActiveRecord::Base
  # Include support for authentication
  include EasyAuth::Models::Account
  # Include support for obfuscated ID
  include ObfuscatedId

  store_accessor :data, :promo_code

  # Relationships
  has_many :identities, :dependent => :destroy, :foreign_key => :account_id
  has_many :networks
  has_many :conversations
  has_many :messages
  has_many :attachments
  has_one :avatar, :dependent => :destroy

  # Validations
  validates :email, :uniqueness => true, :presence => true
  validates_uniqueness_of :slug

  # Callbacks
  after_create do
    self.networks.create(:title => _('%s Network') % self.full_name)
  end

  # Returns user full name
  def full_name
    '%s %s' % [self.first_name, self.last_name]
  end
end
