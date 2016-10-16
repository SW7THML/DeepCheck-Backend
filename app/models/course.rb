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
#  gid        :string           default("")
#  attachment :string
#

class Course < ApplicationRecord
  include Rails.application.routes.url_helpers
  include PhotosHelper

  attr_accessor :attachment
  mount_uploader :attachment, AttachmentUploader

  has_many :posts
  has_many :course_users
  has_many :users, :through => :course_users

  validates :name, presence: true, length: { minimum: 3, maximum: 15 }

  after_create :generate_short_link
  after_create :create_person_group

  def to_json(options={})
    options[:only] ||= [:name]
    super(options)
  end
  
  def generate_short_link
    host_name = Rails.configuration.host_name
    link = ios_link_course_url(self, host: host_name)

    bitly = Bitly.new("deepcheck", "R_c1be89e5bafc4f868570f3fd1d4089e2")

    shorten = bitly.shorten(link)

    self.short_link = shorten.short_url
    self.save
  end

  def train
    pg = MSCognitive::PersonGroup.new
    pg.train(self.gid) unless self.gid.blank?
  end

  def create_person_group
    return unless self.gid.blank?

    group_id = Digest::MD5.hexdigest("#{self.id}-#{Time.now.to_i}")
    group_name = "group-#{group_id}"

    pg = MSCognitive::PersonGroup.new
    res = pg.create(group_id, group_name)
    body = res.body
    self.update(:gid => group_id) if body.blank?
  end

  def icon_id
    self.id % Course.icon_list_count
  end

  def self.icon_list_count
    @icons ||= Dir.glob("app/assets/images/course_icons/*.png").length
  end
end
