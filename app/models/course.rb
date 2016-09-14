# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string
#  short_link :string
#  manager_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Course < ApplicationRecord
  has_many :posts
  has_many :course_users
  has_many :users, :through => :course_users
  belongs_to :manager, :class_name => "User", :foreign_key => :manager_id

	after_create :generate_short_link

  def join(user)
    cu = CourseUser.where(:course_id => self.id, :user_id => user.id)
    if cu.nil?
      cu = Course.new
      cu.user = user
      cu.course = self
      cu.save
    end
    cu
  end

  def leave(user)
    cu = CourseUser.where(:course_id => self.id, :user_id => user.id)
    cu.delete if !cu.nil?
  end

	private
	def generate_short_link
		link = ios_link_course_url(self)
		bitly = Bitly.new("deepcheck", KEYS['bitly'])

		shorten = bitly.shorten(link)

		self.short_link = shorten.short_url
		self.save
	end
end
