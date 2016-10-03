class CoursesController < ApplicationController
  before_filter :logged_in?

  def show
    @course = Course.find(params[:id])
    render :layout => true
  end

  def name

  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.manager_id = current_user.id
    @course.users << current_user

    if @course.save
      redirect_to course_path(@course)
    else
      render 'new'
    end
  end

  def update
    @course = Course.find(params[:id])
    @posts = @course.posts
    @photos = @posts.first
    redirect_to(:back)
  end

  def index
    @courses = Course.all
  end

  def destroy
    @course = Course.find(params[:id])
    @post = @course.posts.find(params[:post_id])
    @photo = @post.photos.find(params[:photo_id])
    @post.destroy
    redirect_to course_path
  end

  private
    def course_params
      params.require(:course).permit(:name, :attachment, :date, :short_link, :manager_id)
    end
end
