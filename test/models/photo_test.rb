# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  attachment :string
#  width      :integer          default(0)
#  height     :integer          default(0)
#

require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
