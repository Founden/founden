# Membership class
class Membership < ActiveRecord::Base
  # Include support for obfuscated ID
  include ObfuscatedId

  # store_accessor :data, :attr

  # Relationships
  belongs_to :creator, :class_name => User
  belongs_to :user
  belongs_to :network
  belongs_to :conversation
  has_one :invitation, :as => :membership, :dependent => :destroy

  # Validations
  validates_presence_of :creator, :user
end
