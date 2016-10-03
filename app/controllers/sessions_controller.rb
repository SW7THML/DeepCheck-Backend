class SessionsController < ApplicationController
  def create
    @user = User.find_for_facebook_oauth(env["omniauth.auth"])
    session[:user_id] = @user.id
    flash[:notice] = "logged in!"
    redirect_to '/'
  end 

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end