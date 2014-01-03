# Invitation class
class Invitation < ActiveRecord::Base
  # Include support for obfuscated ID
  include ObfuscatedId

  # store_accessor :data, :attr

  # Relationships
  belongs_to :user
  belongs_to :membership, :polymorphic => true

  # Validations
  validates_presence_of :user, :email

  # Callbacks
  after_commit :email_invitation, :on => :create

  private

  # Emails the invitation
  def email_invitation
    QC.enqueue('UserMailer.deliver', :invite, self.id)
  end
end
