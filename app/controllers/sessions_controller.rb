class SessionsController < ApplicationController
  def create
    @user = User.find_for_facebook_oauth(env["omniauth.auth"])
    token = env["omniauth.auth"]["credentials"]["token"]

    session[:user_id] = @user.id
    session[:token] = token

    flash[:notice] = "로그인되었습니다."
    url = env["omniauth.params"]["redirect_url"]
    url = "/" if url.nil? || url.empty?

    if @user.faces.count == 0
      User.download(session[:user_id], session[:token])
    end

    redirect_to url
  end 

  def destroy
    session[:user_id] = nil
    session[:token] = nil
    redirect_to '/'
  end

  def fetch
    unless session[:token].blank?
      User.download(session[:user_id], session[:token])
    end

    render :json => {msg: "ok"}
  end
end
