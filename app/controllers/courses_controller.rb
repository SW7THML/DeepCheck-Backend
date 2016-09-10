class CoursesController < ApplicationController
	def show
		@course = Course.find(params[:id])
    render json: @course.to_json
	end

	def name

	end	
end