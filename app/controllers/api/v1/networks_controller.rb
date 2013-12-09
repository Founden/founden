# API (v1) networks controller class
class Api::V1::NetworksController < Api::V1::ApplicationController
  # Lists available networks
  def index
    render :json => current_account.networks.where(:slug => params[:ids])
  end

  # Lists a network
  def show
    network = current_account.networks.find_by!(:slug => params[:id])
    render :json => network
  end
end
