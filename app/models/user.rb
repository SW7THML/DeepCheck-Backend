class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_many :posts
  has_many :tagged_users
  has_many :photos, :through => :tagged_users
  has_many :course_users
  has_many :courses, :through => :course_users
  has_many :managed_courses, :class_name => "Course", :inverse_of => :manager

  def self.find_for_facebook_oauth(data, provider = "facebook")
    uid = data['extra']['raw_info']['id']
    name = data['extra']['raw_info']['name']
    email = data['extra']['raw_info']['email']

    if user = self.where(:provider => provider, :uid => uid).first
      user
    else
      user = User.new(:provider => "facebook", :uid => uid)
      user.email = "#{uid}@facebook.com"
      user.name = name
      #user.password = Digest::MD5.hexdigest(uid)
      user.save
      user
    end
  end

  def enrolled?(course)
    if course.users.find(self.id)
      return true
    end
    return false
  end

  def manager?(course)
    if course.manager_id == self.id
      return true
    end
    return false
  end

  def attendence?(photo)
    if photo.users.length != 0 and photo.users.find(self.id)
      return true
    end
    return false
  end
end
