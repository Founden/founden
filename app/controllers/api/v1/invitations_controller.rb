# API (v1) invitations controller class
class Api::V1::InvitationsController < Api::V1::ApplicationController
  # Lists available invitations
  def index
    render :json => current_account.invitations.where(:slug => params[:ids])
  end

  # Creates a new invitation
  def create
    network = current_account.networks.find_by!(
      :slug => new_invitation_params[:network_id])
    invitation = current_account.invitations.build(new_invitation_params.merge(
      :user => current_account, :network => network))

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
      invitation.membership = invitation.network.network_memberships.create(
        :creator => invitation.user, :user => current_account)
      invitation.save
    end
    render :json => invitation
  end

  private

  # Allowed params for a new invitation
  def new_invitation_params
    params.require(:invitation).permit(:network_id, :email)
  end
end
