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
  validates_exclusion_of :email, :in => :network_emails

  # Callbacks
  after_commit :email_invitation, :on => :create

  private

  # Network email list
  def network_emails
    self.network ? self.network.contacts.map(&:email) : []
  end

  # Emails the invitation
  def email_invitation
    QC.enqueue('UserMailer.deliver', :invite, self.id)
  end
end
