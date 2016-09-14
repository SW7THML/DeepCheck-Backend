class PostsController < ApplicationController
  # TODO pagination
  def index
    course = Course.find(params[:course_id])

    if current_user.enrolled?(course.id)
      posts = course.posts

      render :json => {
        posts: posts
      }
    else
      render :json => {
        posts: []
      }, :status => 401
    end
  end

  def create
    course = Course.find(params[:course_id])

    if current_user.enrolled?(course.id)
      post = Post.new(post_params)
      post.user = current_user
      post.course = course
      post.save

      render :json => {
        post: post
      }
    else
      render :json => {
        post: {}
      }, :status => 401
    end
  end

  def show
    course = Course.find(params[:course_id])

    if current_user.enrolled?(course.id)
      post = Post.find(params[:id])

      render :json => {
        post: post
      }
    else
      render :json => {
        post: {}
      }, :status => 401
    end
  end

  def update
    post = Post.find(params[:id])

    if post.user_id == current_user.id
      post.update(post_params)

      render :json => {
        post: post
      }
    else
      render :json => {}, :status => 401
    end
  end

  def delete
    post = Post.find(params[:id])

    if post.user_id == current_user.id
      post.delete
      render :json => {}
    else
      render :json => {}, :status => 401
    end
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
