class Post < ApplicationRecord
	belongs_to :course

	has_many :photos
  has_many :comments
end
