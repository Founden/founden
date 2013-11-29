# User network class
class Network < ActiveRecord::Base
  # Include support for obfuscated ID
  extend FriendlyId
  include ObfuscatedId

  # Obfuscates record ID
  friendly_id :obfuscated_id, :use => :slugged

  # store_accessor :data, :attr

  # Relationships
  belongs_to :user

  # Validations
  validates(:title, :presence => true,
            :uniqueness => {:scope => :user_id, :case_sensitive => false} )
end
