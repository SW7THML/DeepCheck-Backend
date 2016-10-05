class PhotosController < ApplicationController
  before_filter :logged_in?

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
    course = Course.find(params[:course_id])
    photo = Photo.find(params[:id])
    if current_user.enrolled?(course)
      users = TaggedUser
        .where(:user_id => current_user.id)
        .where(:photo_id => params[:id])
      if users[0].nil?
        photo.users << current_user
      end
      tu = TaggedUser
        .where(:user_id => current_user.id)
        .where(:photo_id => params[:id])[0]
      tu.x = params[:x]
      tu.y = params[:y]
      tu.save
      render :json => {result: 'Create new Tag'}
    else
      render :json => {result: 'not a member'}
    end
	end 

  def destroy
    course = Course.find(params[:course_id])
    photo = Photo.find(params[:id])
    if current_user.enrolled?(course)
      users = TaggedUser
        .where(:user_id => current_user.id)
        .where(:photo_id => params[:id])
      if not users[0].nil?
        users[0].destroy
        render :json => {result: 'tag deleted'} 
      end
    else
      render :json => {result: 'not a member'}
    end
  end

	def create
		render :json => {photo: nil}
	end

	def photo_params
		params.require(:photo).permit(:attachment, :post_id)
	end
end
