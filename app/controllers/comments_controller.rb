class CommentsController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    @post = @course.posts.find(params[:post_id])
    @comment = @post.comments.create(comment_params)

    if @comment.save
      redirect_to course_post_path(@course, @post)
    else
      redirect_to course_post_path(@course, @post), alert: "최소 한 글자 이상의 댓글을 입력해주세요."
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @post = @course.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    redirect_to course_post_path(@course, @post)
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
  end
end