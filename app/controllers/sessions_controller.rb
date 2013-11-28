# Handles sessions for our app
class SessionsController < ApplicationController
  include EasyAuth::Controllers::Sessions

  # Show available authentication options
  def index
  end

  private

  # Returns location to redirect after signing in failure
  def after_failed_sign_in
    flash[:error] = _('Something went wrong. Please try again.')
    redirect_to sign_in_path
  end

  # Returns location to redirect after signing in
  def after_successful_sign_in_url
    root_path
  end
end
