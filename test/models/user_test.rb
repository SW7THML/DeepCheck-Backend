# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  provider   :string
#  uid        :string
#  name       :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
