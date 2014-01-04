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
  validates_exclusion_of :email, :in => :user_added_contact_emails

  # Callbacks
  after_commit :email_invitation, :on => :create

  private

  # User contact emails list
  def user_added_contact_emails
    self.user ? self.user.added_contacts.pluck('email') + [self.user.email] : []
  end

  # Emails the invitation
  def email_invitation
    QC.enqueue('UserMailer.deliver', :invite, self.id)
  end
end
