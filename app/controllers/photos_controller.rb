class PhotosController < ApplicationController

	def index
		@course = Course.find(params[:course_id])
		@post = @course.posts.find(params[:post_id])
		@photos = @post.photos
		render :json => {photos: @photos}
	end

	def show
		@course = Course.find(params[:course_id])
		@post = @course.posts.find(params[:post_id])
		@photo = @post.photos.find(params[:id])
		render :json => {photo: @photo}
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
