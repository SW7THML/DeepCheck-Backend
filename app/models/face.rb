# == Schema Information
#
# Table name: faces
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  attachment :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  origin_url :string           default("")
#

class Face < ApplicationRecord
  include PhotosHelper

  belongs_to :user
  has_many :course_faces
  attr_accessor :attachment
  mount_uploader :attachment, AttachmentUploader

  def self.download(user_id, url, pid = "")
    pid = url if pid.blank?

    unless f = Face.where(:user_id => user_id, :origin_url => url).first
      Face.create(
        :user_id => user_id,
        :origin_url => url,
        :remote_attachment_url => url
      )
    end
  end

  def add_face(course_user_id)
    course_user = CourseUser.find(course_user_id)
    gid = course_user.course.gid
    uid = course_user.uid
    img_url = self.attachment_url

    logger.info "GID: #{gid}"
    logger.info "UID: #{uid}"

    p = MSCognitive::Person.new
    res = p.add_face(gid, uid, img_url)
    json = JSON.parse(res.body)
    logger.info json
    if fid = json["persistedFaceId"]
      CourseFace.create(
        :course_user_id => course_user.id,
        :fid => fid,
        :face_id => self.id
      )
    end
  end
end
