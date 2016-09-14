# == Schema Information
#
# Table name: tagged_users
#
#  id         :integer          not null, primary key
#  photo_id   :integer
#  user_id    :integer
#  x          :integer
#  y          :integer
#  width      :integer
#  height     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TaggedUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
