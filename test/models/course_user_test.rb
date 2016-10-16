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

require 'test_helper'

class CourseUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
