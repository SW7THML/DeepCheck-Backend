class PostsController < ApplicationController
	def index
		@course = Course.find(params[:course_id])
		@posts = @course.posts
		render :json => {posts: @posts}
	end

	def show
		@course = Course.find(params[:course_id])
		@post = @course.posts.find(params[:id])
		render :json => {post: @post}
	end	

	def create
		course = Course.find(@course_id)
		post = Post.new(post_params)

		if post.save
				render :json => {post: post}
		else
			logger.info photo.errors.to_s
			render :json => {post: nil}
		end
	end

	def post_params
		params.require(:post).permit(:attachment)
	end
end
