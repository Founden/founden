# API (v1) memberships controller class
class Api::V1::MembershipsController < Api::V1::ApplicationController
  # Lists available invitations
  def index
    memberships = Membership.where(:slug => params[:ids],
      :id => current_account_membership_ids, :type => allowed_membership_types)

    render :json => memberships
  end

  # Shows available invitations
  def show
    memberships = Membership.find_by!(:slug => params[:id],
      :id => current_account_membership_ids, :type => allowed_membership_types)

    render :json => memberships
  end

  # Creates a membership
  def create
    user = User.find_by!(:slug => new_membership_params[:user_id],
      :id => current_account_contact_ids)

    conversation = current_account.conversations.find_by!(
      :slug => new_membership_params[:conversation_id])

    membership = ConversationMembership.find_or_initialize_by(
      :user => user, :creator => current_account, :conversation => conversation)

    membership.save if membership.new_record?
    render :json => membership
  end

  # Deletes a membership
  def destroy
    membership = Membership.find_by!(:slug => params[:id],
      :id => current_account_membership_ids, :type => allowed_membership_types)

    membership.destroy

    render :nothing => true, :status => 204
  end

  private

  # Allowed contacts for current_account
  def current_account_contact_ids
    current_account.added_contact_ids + current_account.mutual_contact_ids
  end

  # Allowed memberships for current account
  # Since `created_friendship_ids` have the foreign key
  # we need to add them separately to the IDs pool
  def current_account_membership_ids
    current_account.membership_ids + current_account.created_friendship_ids
  end

  # Only these types are allowed to be managed by users
  # The rest of memberships better be kept private
  def allowed_membership_types
    [ConversationMembership.name, Friendship.name]
  end

  # Allowed params for a new membership
  def new_membership_params
    params.require(:membership).permit(:conversation_id, :user_id)
  end
end
