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

require 'test_helper'

class FaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
