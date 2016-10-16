class UsersController < ApplicationController
  before_filter :logged_in?
  
  def create
    token = params[:token]

    facebook_data = HTTParty.get("https://graph.facebook.com/me", query: {
      access_token: token
    }).parsed_response

    logger.info facebook_data

    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(facebook_data)

    render :json => {user: @user}
  end

  def show
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:token)
  end
end
