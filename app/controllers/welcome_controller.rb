class WelcomeController < ApplicationController
  def index
    @msg = "Hello DeepCheck!"

    redirect_to courses_path if user_signed_in?
  end
end
