class WelcomeController < ApplicationController
  acts_as_token_authentication_handler_for User, except: [:index]

  def index
    @msg = "Hello DeepCheck!"

    redirect_to courses_path if user_signed_in?
  end
end
