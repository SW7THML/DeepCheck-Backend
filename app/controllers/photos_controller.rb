class PhotosController < ApplicationController
	def index
    post = Post.find(params[:post_id])

    if current_user.enrolled?(post.course_id)
      photos = post.photos

      render :json => {
        photos: photos
      }
    else
      render :json => {
        photos: []
      }, :status => 401
    end
	end
	
	def create
    post = Post.find(params[:post_id])

    if current_user.enrolled?(post.course_id)
      photo = Photo.new(photo_params)
      photo.user = current_user
      photo.post = post
      photo.save

      render :json => {
        photo: photo
      }
    else
      render :json => {
        photo: {}
      }, :status => 401
    end
	end

  def update
    photo = Photo.find(params[:id])

    if photo.user_id == current_user.id
      photo.update(photo_params)

      render :json => {
        photo: photo
      }
    else
      render :json => {}, :status => 401
    end
  end

  def delete
    photo = Photo.find(params[:id])

    if photo.user_id == current_user.id
      photo.delete
      render :json => {}
    else
      render :json => {}, :status => 401
    end
  end

  def add_tag
    course = Course.find(params[:course_id])

    # TODO remove duplicated tag on post_id, user_id
    if current_user.enrolled?(course.id)
      tag = TaggedUser.new(tag_params)
      tag.user = current_user
      tag.photo_id = params[:photo_id]
      tag.save

      render :json => {
        tag: tag
      }
    else
      render :json => {}, :status => 401
    end
  end

  def edit_tag
    course = Course.find(params[:course_id])
    tag = TaggedUser.find(params[:id])

    if tag.user_id == current_user.id || course.manager_id == current_user.id
      tag.update(tag_params)
      render :json => {}
    else
      render :json => {}, :status => 401
    end
  end

  def remove_tag
    course = Course.find(params[:course_id])
    tag = TaggedUser.find(params[:id])
    
    if tag.user_id == current_user.id || course.manager_id == current_user.id
      tag.delete
      render :json => {}
    else
      render :json => {}, :status => 401
    end
  end

	def photo_params
		params.require(:photo).permit(:attachment)
	end

	def tag_params
		params.require(:tag).permit(:x, :y, :width, :height)
	end
end
