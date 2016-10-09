class PostsController < ApplicationController
  before_filter :logged_in?
	
	def index
		@course = current_user.courses.find(params[:course_id])
		posts = @course.posts
		render :json => {posts: posts}
  end

  def show
    @course = current_user.courses.find(params[:course_id])
    @course_name = @course.name
    @post = @course.posts.find(params[:id])
    @current_user = current_user
    render :layout => true
  end	

  def create
    @course = current_user.courses.find(params[:course_id])
		post = @course.posts.create(post_params)
		photo = post.photos.create(photo_params)

		if post.save
			redirect_to(:back)
		else
			logger.info photo.errors.to_s
			render :json => {post: nil}
		end
	end

	def photo_params
		params.require(:post).permit(:attachment, :post_id)
	end

	def post_params
		params.require(:post).permit(:course_id, :content)
	end

	def course_params
		params.require(:post).permit(:id)
	end
end
