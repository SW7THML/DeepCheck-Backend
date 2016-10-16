class FacesController < ApplicationController
  def destroy
    face = Face.find(params[:id])
    face.destroy

    redirect_to user_path(face.user)
  end
end
