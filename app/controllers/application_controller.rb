class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?

  def current_user
    @current_user ||=User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def require_user
    signed_in? || redirect_to_login
  end

  def redirect_to_login
    redirect_to '/login?domain=g5searchmarketing.com'
    return false
  end
end
