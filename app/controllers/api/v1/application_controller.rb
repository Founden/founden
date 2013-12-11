# API (v1) application controller class
class Api::V1::ApplicationController < AuthenticatedController

  # Customize serializers scope
  serialization_scope :current_account

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :null_session

  # Handle 404 errors
  rescue_from(ActionController::RoutingError, ActiveRecord::RecordNotFound) do
    render :status => :not_found, :json => {
      :message => _('Resource unavailable')
    }
  end
  # Handle strong parameters exceptions
  rescue_from(ActionController::ParameterMissing) do
    render :status => :bad_request, :json => {
      :message => _('We were expecting a different input')
    }
  end

  private

  # Handles error response for bad requests
  def respond_with_bad_request(errors)
    render :status => :bad_request, :json => {
      :message => errors.full_messages.join(', ') }
  end
end
