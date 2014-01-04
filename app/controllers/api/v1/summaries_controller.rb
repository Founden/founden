# API (v1) Summaries controller class
class Api::V1::SummariesController < Api::V1::ApplicationController
  # Lists available summaries
  def index
    summaries = Summary.where(:slug => params[:ids],
      :conversation_id => current_account.conversation_ids)
    render :json => summaries
  end

  # Lists a summary
  def show
    summary = Summary.find_by!(:slug => params[:id],
      :conversation_id => current_account.conversation_ids)
    render :json => summary
  end
end
