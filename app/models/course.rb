class Course < ApplicationRecord
  has_many :posts
  has_many :course_users
  has_many :users, :through => :course_users
  #belongs_to :manager, :class_name => "User", :foreign_key => :manager_id
end
