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
	has_many :photo
  has_many :comments
end
