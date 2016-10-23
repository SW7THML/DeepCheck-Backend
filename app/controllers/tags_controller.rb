class TagsController < ApplicationController
  before_filter :find_photo, :enrolled?

  def index
    render :json => {
      status: "success",
      data: serialize_tag_users(@photo.tagged_users)
    }.to_json
  end

  def create
    Photo.transaction do
      old_tagged_users = @photo.tagged_users.where(user_id: current_user.id)
      old_tagged_users.destroy_all

      tagged_user = @photo.tagged_users.create! do |tagged_user|
        tagged_user.user_id = current_user.id
        tagged_user.x = params[:x]
        tagged_user.y = params[:y]
        tagged_user.width = params[:width]
        tagged_user.height = params[:height]
      end
    end

    tagged_users = TaggedUser.where(:photo_id => params[:photo_id])
    render :json => {
      status: "success",
      data: serialize_tag_users(@photo.tagged_users)
    }.to_json
  end

  def update
    tagged_users = TaggedUser.where(:id => params[:id])

    if tagged_users.empty?
      render :json => {
        status: "failure",
        message: "태그가 존재하지 않습니다.",
      }

      return
    end

    tagged_user = tagged_users.first

    if tagged_user.user_id == current_user.id
      render :json => {
        status: "failure",
        message: "이미 박스에 태깅되었습니다.",
      }

      return
    end

    if tagged_user.user_id
      render :json => {
        status: "failure",
        message: "이미 태깅된 박스입니다.",
      }

      return
    end

    old_tagged_users = @photo.tagged_users.where(user_id: current_user.id)
    old_tagged_users.destroy_all

    tagged_user.user_id = current_user.id
    tagged_user.save!

    tagged_users = TaggedUser.where(:photo_id => params[:photo_id])
    render :json => {
      status: "success",
      data: serialize_tag_users(@photo.tagged_users)
    }.to_json
  end

  def destroy
    tag = @photo.tagged_users.find(params[:id])
    
    if tag.blank?
      render :json => {
        status: "failure",
        message: "이미 삭제된 태그입니다.",
      }
      return
    end

    course = @photo.post.course

    if not current_user.manager?(course) and tag.user_id != current_user.id
      render :json => {
        status: "failure",
        message: "삭제 권한이 없습니다.",
      }
      return
    end

    tag.destroy

    tagged_users = TaggedUser.where(:photo_id => params[:photo_id])
    render :json => {
      status: "success",
      data: serialize_tag_users(@photo.tagged_users)
    }.to_json
  end

private
  def find_photo
    @photo = Photo.find(params[:photo_id])
  end

  def enrolled?
    # No need to receive a kindness message for hacker.
    @photo.post.course.users.find(current_user.id)
  end

  def serialize_tag_users(tag_users)
    course = @photo.post.course
    tag_users.to_a.map do |tag|
      attributes = tag.attributes.slice(*TaggedUser::JSON_RECORD)
      attributes[:user] = {name: tag.user.name} if tag.user
      attributes[:delete] = (current_user == tag.user or current_user.manager?(course))
      attributes
    end
  end
end