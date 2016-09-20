class CoursesController < ApplicationController
	def index
		@course = Course.all
		render :json => {courses: @course}
	end

	def show
		@course = Course.find(params[:id])
		render :layout => true
	end

	def update
		@course = Course.find(params[:id])
		@posts = @course.posts
		@photos = @posts.first
		redirect_to(:back)
	end

	def course_params
			params.require(:course).permit(:name, :attachment, :date, :short_link, :manager_id)
	end
end