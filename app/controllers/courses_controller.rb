class CoursesController < ApplicationController
  def name

  end

  def show
    @course = Course.find(params[:id])
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