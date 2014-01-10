# Mailer to handle user emails
class UserMailer < ApplicationMailer
  # Sends an invitation
  def invite(invitation_id)
    @invitation = Invitation.find(invitation_id)
    mail(:to => @invitation.email, :subject => _('%s invites you to use %s.') % [
      @invitation.user.full_name, Founden::Config.app_name])
  end

  # Sends a conversation mention
  def mention(message_id, user_id)
    @message = Message.find(message_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => _('%s mentioned you in %s on %s.') % [
      @message.user.full_name, @message.conversation.title,
      Founden::Config.app_name])
  end
end
