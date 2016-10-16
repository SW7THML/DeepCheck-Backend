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

require 'test_helper'

class CourseFaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
