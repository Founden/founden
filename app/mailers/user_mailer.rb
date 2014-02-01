# Mailer to handle user emails
class UserMailer < ApplicationMailer
  # Sends an invitation
  def invite(invitation_id)
    @invitation = Invitation.find(invitation_id)
    mail(:to => @invitation.email, :subject => _('%s invites you to use %s.') % [
      @invitation.user.full_name, Founden::Config.app_name])
  end

  # Sends a conversation mention
  def mention(conversation_id, user_id, author_id)
    @conversation = Conversation.find(conversation_id)
    @user = User.find(user_id)
    @author = User.find(author_id)
    mail(:to => @user.email, :subject => _('%s mentioned you in %s on %s.') % [
      @author.full_name, @conversation.title, Founden::Config.app_name
    ])
  end
end
