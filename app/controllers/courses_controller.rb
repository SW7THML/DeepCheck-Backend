class CoursesController < ApplicationController
	def show
		@course = Course.find(params[:id])
	end

	def name

	end	

	def new
		@course = Course.new
	end

	def create
		@course = Course.new(course_params)

		if @course.save
			redirect_to course_path(@course)
		else
			render 'new'
		end
	end

	def index
		@courses = Course.all
	end

	private
		def course_params
			params.require(:course).permit(:name)
		end
end