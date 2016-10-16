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
  JSON_RECORD = ["id", "photo_id", "user_id", "x", "y", "width", "height"]

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

  def self.by_photo(photo_id)
    TaggedUser
      .where(:photo_id => photo_id)
      .where.not(:user_id => nil)
      # .to_json(:include => {:user => {:only => :name}}
  end

  def as_json(options={})
    super(:include => {:user => {:only => :name}}, only: JSON_RECORD)
  end
end
