# API (v1) memberships controller class
class Api::V1::MembershipsController < Api::V1::ApplicationController
  # Creates a membership
  def create
    user = User.find_by!(:slug => new_membership_params[:user_id])
    network = current_account.networks.find_by!(
      :slug => new_membership_params[:network_id])
    conversation = current_account.conversations.find_by!(
      :slug => new_membership_params[:conversation_id], :network => network
    ) if new_membership_params[:conversation_id]


    klass = conversation ? ConversationMembership : NetworkMembership

    membership = klass.find_or_initialize_by(
      :user => user, :network => network, :creator => current_account)
    membership.conversation = conversation if conversation

    if membership.save
      render :json => membership
    else
      respond_with_bad_request(membership.errors)
    end
  end

  private

  # Allowed params for a new membership
  def new_membership_params
    params.require(:membership).permit(:network_id, :conversation_id, :user_id)
  end
end
