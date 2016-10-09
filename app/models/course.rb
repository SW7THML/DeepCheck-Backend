class Course < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :posts
  has_many :course_users
  has_many :users, :through => :course_users

  validates :name, presence: true, length: { minimum: 3, maximum: 15 }

  after_create :generate_short_link

  def to_json(options={})
    options[:only] ||= [:name]
    super(options)
  end
  
  private
    def generate_short_link
      host_name = Rails.configuration.host_name
      link = ios_link_course_url(self, host: host_name)

      bitly = Bitly.new("deepcheck", "R_c1be89e5bafc4f868570f3fd1d4089e2")

      shorten = bitly.shorten(link)

      self.short_link = shorten.short_url
      self.save
    end
end