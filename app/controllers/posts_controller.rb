class PostsController < ApplicationController
  before_filter :logged_in?
	
	def index
		@course = current_user.courses.find(params[:course_id])
		posts = @course.posts
		render :json => {posts: posts}
  end

  def show
    @course = current_user.courses.find(params[:course_id])
    @post = @course.posts.find(params[:id])
    @post_title = @post.created_at.strftime("%m월 %d일")

    # if @post.
    #   redirect_to course_post_path(@course, @post)
    # else
    #   redirect_to course_path(@course), alert: "로딩중입니다 잠시만 기다려 주세요."
    # end

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
