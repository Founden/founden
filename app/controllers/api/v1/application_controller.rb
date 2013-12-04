# API (v1) application controller class
class Api::V1::ApplicationController < AuthenticatedController

  # Customize serializers scope
  serialization_scope :current_account

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :null_session
end
