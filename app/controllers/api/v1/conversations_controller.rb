# API (v1) Conversation controller class
class Api::V1::ConversationsController < Api::V1::ApplicationController
  # Lists available conversations
  def index
    conversations = current_account.conversations.where(:slug => params[:ids])
    render :json => conversations
  end

  # Lists a conversation
  def show
    conversation = current_account.conversations.find_by!(:slug => params[:id])
    render :json => conversation
  end

  # Create a conversation
  def create
    conversation = current_account.conversations.build(
      new_conversation_params.merge(:user => current_account))

    if conversation.save
      render :json => conversation
    else
      respond_with_bad_request(conversation.errors)
    end
  end

  private

  # Parameters for creating a new conversation
  def new_conversation_params
    params.require(:conversation).permit(:title)
  end
end
