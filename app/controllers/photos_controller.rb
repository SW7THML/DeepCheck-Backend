class PhotosController < ApplicationController

	def index
		@course = Course.find(params[:course_id])
		post = @course.posts.find(params[:post_id])
		photos = post.photos
		render :json => {photos: photos}
	end

	def show
		@course = Course.find(params[:course_id])
		post = @course.posts.find(params[:post_id])
		photo = post.photos.find(params[:id])

		render :json => {photo: photo.attachment, date: photo.created_at}
	end

	def update
    if current_user.enrolled?(course.id)
    	render :json => {tag: false}
    else
    	render :json => {tag: false}
    end
	end 

	def create
		render :json => {photo: nil}
	end

	def photo_params
		params.require(:photo).permit(:attachment, :post_id)
	end
end
