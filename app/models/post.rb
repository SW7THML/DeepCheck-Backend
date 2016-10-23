# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  taken_at   :datetime
#

class Post < ApplicationRecord
  belongs_to :course

  has_many :photos
  has_many :comments

  def self.latest
    self.order(:created_at => :desc)
  end

  def attendance
    attendance_list = []
    self.photos.each do |photo|
      photo.users.each do |user|
        attendance_list.push(user)
      end
    end
    return attendance_list
  end

  def limit(img, width, height)
    img.resize "#{width}x#{height}>"
  end
end
