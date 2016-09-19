class PhotosController < ApplicationController

	def index
		render :json => {photos: []}
	end
	
	def create
		course = Course.first
		post = course.posts.first

		photo = Photo.new(photo_params)
		photo.post = post

		if photo.save
				render :json => {photo: photo}
		else
		logger.info photo.errors.to_s
				render :json => {photo: nil}
		end
	end

	def photo_params
		params.require(:photo).permit(:attachment)
	end
end
