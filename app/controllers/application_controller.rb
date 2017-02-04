class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected

  def fetch_current_user
    @user ||= authenticate_user || render_not_found
  end

  def authenticate_user
    authenticate_with_http_token do |token, opts|
      User.find_by(api_auth_token: token)
    end
  end

  def render_not_found
    head(404)
  end
end
