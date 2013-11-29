# Application user class
class User < ActiveRecord::Base
  # Include support for authentication
  include EasyAuth::Models::Account
  # Include support for obfuscated ID
  extend FriendlyId
  include ObfuscatedId

  # Obfuscates record ID
  friendly_id :obfuscated_id, :use => :slugged

  store_accessor :data, :promo_code

  # Relationships
  has_many :identities, :dependent => :destroy, :foreign_key => :account_id
  has_many :networks

  # Validations
  validates :email, :uniqueness => true, :presence => true
end
