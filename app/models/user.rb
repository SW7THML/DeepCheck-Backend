class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :comments
  has_many :posts

  def self.find_for_facebook_oauth(data, provider = "facebook")
    uid = data['id']
    if user = self.where(:provider => provider, :uid => uid).first
      user
    else
      user = User.new(:provider => "facebook", :uid => uid)
      user.email = "#{uid}@facebook.com"
      #user.password = Digest::MD5.hexdigest(uid)
      user.save
      user
    end
  end
end
