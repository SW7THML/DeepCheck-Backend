class IosLinkController < ApplicationController
  def show
    @course = Course.find(params[:id])
  end

  def name

  end
end