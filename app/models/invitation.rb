# Invitation class
class Invitation < ActiveRecord::Base
  # Include support for obfuscated ID
  include ObfuscatedId

  # store_accessor :data, :attr

  # Relationships
  belongs_to :user
  belongs_to :network
  belongs_to :membership, :polymorphic => true

  # Validations
  validates_presence_of :user, :email, :network

  # Callbacks
  after_create do
    # Call mailer
  end
end
