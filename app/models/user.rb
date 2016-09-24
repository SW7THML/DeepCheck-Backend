# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  authentication_token   :string(30)
#

class User < ApplicationRecord
	acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,# :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_many :posts
  has_many :tagged_users
  has_many :photos, :through => :tagged_users
  has_many :course_users
  has_many :courses, :through => :course_users
  has_many :managed_courses, :class_name => "Course", :foreign_key => :manager

  def enrolled?(course_id)
    cu = CourseUser.where(:course_id => course_id, :user_id => self.id).first
    !cu.nil?
  end

  def self.find_for_facebook_oauth(data, provider = "facebook")
    uid = data['id']
    if user = self.where(:provider => provider, :uid => uid).first
      user
    else
      user = User.new(:provider => "facebook", :uid => uid)
      user.email = "#{uid}@facebook.com"
      user.password = Digest::MD5.hexdigest(uid)
      user.save
      user
    end
  end
end
