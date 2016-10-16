# == Schema Information
#
# Table name: tagged_users
#
#  id         :integer          not null, primary key
#  photo_id   :integer
#  user_id    :integer
#  x          :float
#  y          :float
#  width      :integer
#  height     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fid        :string           default("")
#

class TaggedUser < ApplicationRecord
  belongs_to :photo
  belongs_to :user

  def scale
    pwidth = self.photo.width.to_f
    pheight = self.photo.height.to_f

    self.x = (self.x / pwidth) * 100
    self.y = (self.y / pheight) * 100
    self.width = (self.width / pwidth) * 100
    self.height = (self.height / pheight) * 100
    self.save
  end
end
