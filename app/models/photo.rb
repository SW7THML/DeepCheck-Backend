# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  attachment :string
#  user_id    :integer
#

class Photo < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader

  belongs_to :post
  has_many :tagged_users
  has_many :users, :through => :tagged_users
end
