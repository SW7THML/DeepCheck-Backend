# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Post < ApplicationRecord
	belongs_to :user
	belongs_to :course

	has_many :photos
  has_many :comments

  def self.latest
    self.order(:created_at => :desc)
  end
end
