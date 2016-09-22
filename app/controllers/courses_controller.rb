class CoursesController < ApplicationController
  # TODO pagintation
	def index
		@courses = Course.all
    @my_courses = current_user.courses
	end

  def create
    course = Course.new(course_params)
    course.manager = current_user
    course.save

    course.generate_short_link
    course.join(current_user)

    redirect_to courses_path
  end

  def leave
    course = Course.find(params[:id])
    course.leave(current_user)

    redirect_to courses_path
  end

	def show
    @course = Course.find(params[:id])
	end

	def update
		course = Course.find(params[:id])

		if course.manager_id == current_user.id
			course.update(course_params)
		end

    redirect_to courses_path(course)
	end

  def delete
    course = Course.find(params[:id])

    if course.manager_id == current_user.id
      # TODO need to add condition
      course.delete
    end

    redirect_to courses_path
  end

  def course_params
		params.require(:course).permit(:name, :attachment, :date)
  end
end
