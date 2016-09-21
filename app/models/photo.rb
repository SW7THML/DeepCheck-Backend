class Photo < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
	belongs_to :post

  has_many :tagged_users
  has_many :users, :through => :tagged_users
end
