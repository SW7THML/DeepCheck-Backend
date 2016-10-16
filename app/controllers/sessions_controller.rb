class SessionsController < ApplicationController
  def create
    @user = User.find_for_facebook_oauth(env["omniauth.auth"])
    session[:user_id] = @user.id
    flash[:notice] = "logged in!"
    url = env["omniauth.params"]["redirect_url"]
    url = "/" if url.nil? || url.empty?
    redirect_to url
  end 

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
