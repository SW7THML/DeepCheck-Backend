class Post < ApplicationRecord
belongs_to :course
has_many :photo
end
