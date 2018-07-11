class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def login_user!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_logged_in
    redirect_to new_user_url unless logged_in?
  end
  
  def already_signed_in?
    redirect_to cats_url if logged_in?
  end
  
end
