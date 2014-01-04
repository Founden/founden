# API (v1) memberships controller class
class Api::V1::MembershipsController < Api::V1::ApplicationController
  # Creates a membership
  def create
    user = User.find_by!(:slug => new_membership_params[:user_id])
    conversation = current_account.conversations.find_by!(
      :slug => new_membership_params[:conversation_id])

    membership = ConversationMembership.find_or_initialize_by(
      :user => user, :creator => current_account, :conversation => conversation)

    if membership.save
      render :json => membership
    else
      respond_with_bad_request(membership.errors)
    end
  end

  private

  # Allowed params for a new membership
  def new_membership_params
    params.require(:membership).permit(:conversation_id, :user_id)
  end
end
