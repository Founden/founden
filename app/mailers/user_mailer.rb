# Mailer to handle user emails
class UserMailer < ApplicationMailer
  # Sends an invitation
  def invite(invitation_id)
    @invitation = Invitation.find(invitation_id)
    mail(:to => @invitation.email, :subject => _('%s invites you to use %s.') % [
      @invitation.user.full_name, Founden::Config.app_name])
  end
end
