class Api::CoursesController < ApplicationController
  # TODO pagintation
	def index
		courses = Course.all
    my_courses = current_user.courses

    render :json => {
      courses: courses,
      my_courses: my_courses
    }
	end

  def create
    course = Course.new(course_params)
    course.manager = current_user
    course.save

    course.generate_short_link
    course.join(current_user)

    render :json => {
      course: course
    }
  end

  def join
    course = Course.find(params[:id])
    course.join(current_user)

    render :json => {
      course: course
    }
  end

  def leave
    course = Course.find(params[:id])
    course.leave(current_user)

    render :json => {
    }
  end

	def show
		respond_to do |format|
			format.html {
				@course = Course.find(params[:id])
			}
			format.json {
				course = Course.find(params[:id])

				if current_user.enrolled?(course.id)
					render :json => {
						course: course
					}
				else
					render :json => {
						course: {}
					}, :status => 401
				end
			}
		end
	end

	def update
		course = Course.find(params[:id])

		if course.manager_id == current_user.id
			course.update(course_params)

			render :json => {
				course: course
			}
		else
			render :json => {}, :status => 401
		end
	end

  def delete
    course = Course.find(params[:id])

    if course.manager_id == current_user.id
      # TODO need to add condition
      course.delete
      render :json => {}
    else
      render :json => {}, :status => 401
    end
  end

  def course_params
    #params.require(:course).permit(:name)
		params.require(:course).permit(:name, :attachment, :date)
  end
end
