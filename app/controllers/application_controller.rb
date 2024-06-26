class ApplicationController < ActionController::Base

  protect_from_forgery unless: -> { request.format.json? || request.format.xml? }

  # All pages require a login...
  before_action :authenticate_user!

  # Stub
  def current_token
    nil
  end
  helper_method :current_token

  # Stub
  def token_user?
    !!current_token
  end

  helper_method :token_user?
end
