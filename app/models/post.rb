class Post < ApplicationRecord
  belongs_to :course

  has_many :photos
    has_many :comments

  def self.latest
    self.order(:created_at => :desc)
  end
end