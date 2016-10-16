# == Schema Information
#
# Table name: course_faces
#
#  id             :integer          not null, primary key
#  course_user_id :integer
#  fid            :string           default("")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  face_id        :integer
#

class CourseFace < ApplicationRecord
  belongs_to :course_user
  belongs_to :face
end
