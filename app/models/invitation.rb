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
  after_commit :email_invitation, :on => :create

  # Returns the user with the invitation email
  def invitee
    User.find_by(:email => self.email)
  end

  private

  # Emails the invitation
  def email_invitation
    QC.enqueue('UserMailer.deliver', :invite, self.id)
  end
end
