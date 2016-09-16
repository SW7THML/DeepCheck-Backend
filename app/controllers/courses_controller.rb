class CoursesController < ApplicationController
	def index
		@course = Course.all
		render :json => {courses: @course}
	end

	def show
		@course = Course.find(params[:id])
		#raise @course.inspect
		render :layout => true
	end

	def update
		@course = Course.find(params[:id])
		@posts = @course.posts
		@photos = @posts.first
		raise @photos.inspect
		raise params.inspect
		redirect_to :root
	end

	def course_params
			params.require(:course).permit(:name, :photo, :date, :short_link, :manager_id)
	end
end