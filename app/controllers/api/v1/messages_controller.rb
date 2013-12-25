# API (v1) Messages controller class
class Api::V1::MessagesController < Api::V1::ApplicationController
  # Lists available messages
  def index
    messages = Message.where(
      :slug => params[:ids], :network_id => current_account.network_ids)
    render :json => messages
  end

  # Lists a message
  def show
    message = Message.find_by!(
      :slug => params[:id], :network_id => current_account.network_ids)
    render :json => message
  end

  # Create a message
  def create
    network = current_account.networks.find_by!(
      :slug => new_message_params[:network_id])

    conversation = network.conversations.find_by!(
      :slug => new_message_params[:conversation_id])

    parent_message = conversation.messages.find_by!(
      :slug => new_message_params[:parent_message_id]
    ) if new_message_params[:parent_message_id]

    message = conversation.messages.build(new_message_params.merge(
      :network => network, :user => current_account,
      :parent_message => parent_message))

    if message.save
      render :json => message
    else
      respond_with_bad_request(message.errors)
    end
  end

  # Updates a message
  def update
    message = Message.find_by!(
      :slug => params[:id], :network_id => current_account.network_ids)

    unless message_params[:summary_id].blank?
      message.summary = message.conversation.summary || Summary.create!(
        :conversation => message.conversation, :network => message.network)
      message.save
    else
      message.update_attributes(:summary => nil)
    end

    render :json => message
  end

  private

  # Parameters for updating a message
  def message_params
    params.require(:message).permit(:summary_id)
  end

  # Parameters for creating a new message
  def new_message_params
    params.require(:message).permit(
      :content, :network_id, :conversation_id, :parent_message_id)
  end
end
