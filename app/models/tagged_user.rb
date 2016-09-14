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

class TaggedUser < ApplicationRecord
  belongs_to :photo
  belongs_to :user
end
