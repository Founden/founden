# Application user class
class User < ActiveRecord::Base
  # Include support for authentication
  include EasyAuth::Models::Account

  store_accessor :data, :promo_code

  # Relationships
  has_many :identities, :dependent => :destroy, :foreign_key => :account_id

  # Validations
  validates :email, :uniqueness => true, :presence => true
end
