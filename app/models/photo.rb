class Photo < ApplicationRecord
	belongs_to :post
	mount_uploader :attachment, AttachmentUploader
end
