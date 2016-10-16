class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    redirect_to login_path(:redirect_url => request.url) unless session[:user_id]
  end
end
