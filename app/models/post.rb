class Post < ApplicationRecord
	belongs_to :course
	has_many :photo
  has_many :comments
end
