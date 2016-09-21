class WelcomeController < ApplicationController
  def index
		if user_signed_in?
			redirect_to courses_path
			return
		end

    @msg = "Hello DeepCheck!"

    respond_to do |format|
      format.html
      format.json {
        render :json => {
          msg: @msg
        }, :status => 403
      }
    end
  end
end
