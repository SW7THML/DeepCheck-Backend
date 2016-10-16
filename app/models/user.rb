# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  provider   :string
#  uid        :string
#  name       :string
#

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
  has_many :faces

  def self.find_for_facebook_oauth(data, provider = "facebook")
    uid = data['extra']['raw_info']['id']
    name = data['extra']['raw_info']['name']
    email = data['extra']['raw_info']['email']

    if user = self.where(:provider => provider, :uid => uid).first
      user
    else
      User.create do |user|
        user.provider = "facebook"
        user.uid = uid
        user.email = "#{uid}@facebook.com"
        user.name = name
      end
    end
  end

  def self.download(user_id, token)
    require 'koala'

    graph = Koala::Facebook::API.new(token)

    res = graph.get_connections('me', 'albums')

    album_id = 0
    res.each do |a|
      name = a['name']
      if name == "Profile Pictures"
        album_id = a['id']
      end
    end

    res = graph.get_object('me', {fields: ["id", "name"]})
    id = res["id"]
    url = "http://graph.facebook.com/v2.7/#{id}/picture?type=large&redirect=false"

    json = JSON.parse(Net::HTTP.get(URI(url)))
    url = json["data"]["url"]

    photos = [
      {
        id: id,
        url: url
      }
    ]

    if album_id.to_i != 0
      ps = graph.get_connections(album_id, 'photos', {limit: 20, fields: ["id", "source", "images", "height", "width", "created_time"]})
      ps.each do |p|
        id = p['id']
        url = p['source']

        photos << {
          id: id,
          url: url
        }
      end
    end

    DownloadJob.set(wait: 1.second).perform_later({
      user_id: user_id,
      photos: photos
    })
  end

  def enrolled?(course)
    course.users.exists?(self.id)
  end

  def tagged?(photo)
    TaggedUser
      .where(:photo_id => photo.id)
      .where(:user_id => self.id).any?
  end

  def manager?(course)
    course.manager_id == self.id
  end

  def attendence?(photo)
    photo.users.where(:id => self.id).any?
  end
end
