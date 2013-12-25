# API (v1) Summaries controller class
class Api::V1::SummariesController < Api::V1::ApplicationController
  # Lists available summaries
  def index
    summaries = Summary.where(
      :slug => params[:ids], :network_id => current_account.network_ids)
    render :json => summaries
  end

  # Lists a summary
  def show
    summary = Summary.find_by!(
      :slug => params[:id], :network_id => current_account.network_ids)
    render :json => summary
  end
end
