# == Schema Information
#
# Table name: course_users
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uid        :string           default("")
#

class CourseUser < ApplicationRecord
  include PhotosHelper

  belongs_to :course
  belongs_to :user
  has_many :course_faces

  after_create :create_person
  after_create :create_faces

  def create_person
    return unless self.uid.blank?

    person_name = "person-#{self.id}"
    person_user_data = "CourseUser:#{self.id}"

    p = MSCognitive::Person.new
    res = p.create(self.course.gid, person_name, person_user_data)
    json = JSON.parse(res.body)
    if uid = json["personId"]
      self.update(:uid => uid)
    end
  end

  def create_faces
    self.user.faces.each do |f|
			logger.info "add_face #{f.id}"
      unless cf = self.course_faces.where(:face_id => f.id).first
        f.add_face(self.id) 
      end
    end
  end
end
