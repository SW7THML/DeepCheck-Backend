class PhotosController < ApplicationController
  before_filter :logged_in?

	def index
		@course = current_user.courses.find(params[:course_id])
		post = @course.posts.find(params[:post_id])
		photos = post.photos
		render :json => {photos: photos}
	end

	def show
		@course = current_user.courses.find(params[:course_id])
		post = @course.posts.find(params[:post_id])
		photo = post.photos.find(params[:id])

		render :json => {photo: photo.attachment, date: photo.created_at}
	end

	def update
    course = current_user.courses.find(params[:course_id])
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
      tu.width = params[:width]
      tu.height = params[:height]
      tu.save
      render :json => {result: 'Create new Tag'}
    else
      render :json => {result: 'not a member'}
    end
	end 

  def destroy
    course = current_user.courses.find(params[:course_id])
    user = course.users.find(params[:uid])
    post = course.posts.find(params[:post_id])
    photo = post.photos.find(params[:id])

    if current_user.manager?(course) or user == current_user
      tagged_photo = current_user.tagged_users.find_by_photo_id!(params[:id])
      tagged_photo.destroy

      render :json => {result: 'tag deleted'}
    else
      render :json => {result: 'permission error'}
    end
  end

	def create
		render :json => {photo: nil}
	end

	def photo_params
		params.require(:photo).permit(:attachment, :post_id)
	end
end
