class Api::CommentsController < ApplicationController
  # TODO pagination
  def index
    post = Post.find(params[:post_id])

    if current_user.enrolled?(post.course_id)
      comments = post.comments

      render :json => {
        comments: comments
      }
    else
      render :json => {
        comments: []
      }, :status => 401
    end
  end

  def create
    post = Post.find(params[:post_id])

    if current_user.enrolled?(post.course_id)
      comment = Comment.new(comment_params)
      comment.user = current_user
      comment.course = post.course
      comment.save

      render :json => {
        comment: comment
      }
    else
      render :json => {
        comment: {}
      }, :status => 401
    end
  end

  def update
    comment = Comment.find(params[:id])

    if comment.user_id == current_user.id
      comment.update(comment_params)

      render :json => {
        comment: comment
      }
    else
      render :json => {}, :status => 401
    end
  end

  def delete
    comment = Comment.find(params[:id])

    if comment.user_id == current_user.id
      comment.delete
      render :json => {}
    else
      render :json => {}, :status => 401
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
