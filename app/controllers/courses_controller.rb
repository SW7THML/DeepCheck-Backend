class CoursesController < ApplicationController
	def index
		@course = Course.all
		render :json => {course: @course}
	end
end