# Mailer to handle user emails
class UserMailer < ApplicationMailer
  # Sends an invitation
  def invite(email, user)
    @email = email
    @user = user
    mail(:to => email, :subject => _('%s invites you to use %s.') % [
      user.full_name, Founden::Config.app_name])
  end
end
