class WelcomeController < ApplicationController
  def test
    logger.info request.headers['Content-Type']
    logger.info request.headers['Ocp-Apim-Subscription-Key']
    render :json => {msg: "ok"}
  end
end
