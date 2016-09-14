class UsersController < ApplicationController
  acts_as_token_authentication_handler_for User, except: [:create]

  def create
    token = params[:token]

    facebook_data = HTTParty.get("https://graph.facebook.com/me", query: {
      access_token: token
    }).parsed_response

    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(facebook_data)

    render :json => {user: @user}
  end

  def user_params
    params.require(:token)
  end
end
