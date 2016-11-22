# == Schema Information
#
# Table name: courses
#
#  id                  :integer          not null, primary key
#  name                :string
#  short_link          :string
#  manager_id          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  gid                 :string           default("")
#  attachment          :string
#  training_user_count :integer          default(0)
#

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
