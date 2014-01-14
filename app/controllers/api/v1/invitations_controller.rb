# API (v1) invitations controller class
class Api::V1::InvitationsController < Api::V1::ApplicationController
  # Lists available invitations
  def index
    render :json => current_account.invitations.where(:slug => params[:ids])
  end

  # Shows the available invitation
  def show
    invitation = Invitation.find_by!(
      :slug => params[:id], :email => current_account.email)
    render :json => invitation
  end

  # Creates a new invitation
  def create
    invitation = current_account.invitations.build(
      new_invitation_params.merge(:user => current_account))

    if invitation.save
      render :json => invitation
    else
      respond_with_bad_request(invitation.errors)
    end
  end

  # Updates a new invitation
  def update
    invitation = Invitation.find_by!(
      :slug => params[:id], :email => current_account.email)

    if invitation and !invitation.membership
      invitation.membership = invitation.user.created_friendships.create(
        :creator => invitation.user, :user => current_account)
      invitation.save(:validate => false)
    end
    render :json => invitation
  end

  private

  # Allowed params for a new invitation
  def new_invitation_params
    params.require(:invitation).permit(:email)
  end
end
