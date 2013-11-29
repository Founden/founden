# Conversation class
class Conversation < ActiveRecord::Base

  # Include support for obfuscated ID
  extend FriendlyId
  include ObfuscatedId

  # Obfuscates record ID
  friendly_id :obfuscated_id, :use => :slugged

  # store_accessor :data, :key

  # Relationships
  belongs_to :user
  belongs_to :network

  # Validations
  validates_presence_of :title
end
