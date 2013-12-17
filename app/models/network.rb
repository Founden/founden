# User network class
class Network < ActiveRecord::Base
  # Include support for obfuscated ID
  include ObfuscatedId

  # store_accessor :data, :attr

  # Relationships
  belongs_to :user
  has_many :conversations
  has_many :messages
  has_many :attachments

  has_one :owner_membership, :dependent => :destroy
  has_many :network_memberships, :dependent => :destroy
  has_many :contacts, :through => :network_memberships, :source => :user

  has_many :invitations, :dependent => :destroy

  # Validations
  validates_presence_of :title, :user
  validates_uniqueness_of :title, :scope => :user_id, :case_sensitive => false
  validates_uniqueness_of :slug

  # Callbacks
  before_validation do
    self.title = Sanitize.clean(self.title)
  end
  after_create do
    self.create_owner_membership(:creator => self.user, :user => self.user)
  end
end
