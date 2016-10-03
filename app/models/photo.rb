class Photo < ApplicationRecord
  attr_accessor :attachment
  mount_uploader :attachment, AttachmentUploader
	belongs_to :post

  has_many :tagged_users
  has_many :users, :through => :tagged_users
end
