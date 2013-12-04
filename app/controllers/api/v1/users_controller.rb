# API (v1) users controller class
class Api::V1::UsersController < Api::V1::ApplicationController
  # Lists available users
  def index
    render :json => [current_account]
  end

  # Shows an user
  def show
    user = User.find_by(:slug => params[:id])
    render :json => (user || current_account)
  end
end
