class WelcomeController < ApplicationController
  def index
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
