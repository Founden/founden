# API (v1) Attachments controller class
class Api::V1::AttachmentsController < Api::V1::ApplicationController
  ALLOWED_TYPES = %w(avatar link location task_list timestamp upload)
  # Queried attachment_type
  attr_accessor :attachment_type

  # Lists available attachments
  def index
    attachments = Attachment.where(
      :slug => params[:ids], :conversation_id => current_account.conversation_ids)
    render :json => attachments
  end

  # Lists an attachment
  def show
    attachment = Attachment.find_by!(:slug => params[:id],
      :conversation_id => current_account.conversation_ids + [nil])
    render :json => attachment
  end

  # Create an attachment
  def create
    conversation = current_account.conversations.find_by!(
      :slug => new_attachment_params[:conversation_id])

    message = conversation.messages.find_by!(
      :slug => new_attachment_params[:message_id])

    klass = (@attachment_type.to_s.camelize).safe_constantize

    attachment = klass.new(new_attachment_params.merge(:user => current_account,
      :conversation => conversation, :message => message))

    if attachment.save
      render :json => attachment
    else
      respond_with_bad_request(attachment.errors)
    end
  end

  private

  # Parameters for creating a new attachment
  def new_attachment_params
    @attachment_type = params.slice(*ALLOWED_TYPES).keys.first
    params[@attachment_type].except!(:type) if @attachment_type
    params.require(@attachment_type).permit!
  end
end
