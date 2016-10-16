# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  attachment :string
#

class Photo < ApplicationRecord
  include PhotosHelper

  attr_accessor :attachment
  mount_uploader :attachment, AttachmentUploader
	belongs_to :post

  has_many :tagged_users
  has_many :users, :through => :tagged_users

	after_create :process
  #after_create :get_size
	#after_create :detect
	#after_create :identify

  def process
    logger.info "process"
    RecognitionJob.set(wait: 5.second).perform_later({
      photo_id: self.id,
    })
  end

	def get_size
    puts self.attachment_url
		fid = self.attachment_url.split("/").last.split(".png").first
		data = Cloudinary::Api.resource(fid)
		# {"public_id"=>"hnv4srbwkmckpggdpqtk", "format"=>"png", "version"=>1476592758, "resource_type"=>"image", "type"=>"upload", "created_at"=>"2016-10-16T04:39:18Z", "bytes"=>434002, "width"=>599, "height"=>599, "url"=>"http://res.cloudinary.com/hklr581g0/image/upload/v1476592758/hnv4srbwkmckpggdpqtk.png", "secure_url"=>"https://res.cloudinary.com/hklr581g0/image/upload/v1476592758/hnv4srbwkmckpggdpqtk.png", "next_cursor"=>"b3b67847afa863593e234006fd47ba30", "derived"=>[]}
		width = data["width"]
		height = data["height"]
		self.update(:width => width, :height => height)
	end

  def identify
		# need to train
		self.post.course.train

    face_ids = self.tagged_users.map {|tu| tu.fid}
		face_ids = face_ids.compact.reject(&:blank?)
    face_ids = face_ids.uniq

    course = self.post.course

    f = MSCognitive::Face.new
    res = f.identify(course.gid, face_ids)
    faces = JSON.parse(res.body)
    logger.info faces
    faces.each do |face|
      fid = face["faceId"]
      people = face["candidates"]
      
      if t = TaggedUser.where(:fid => fid).first
        people.each do |p|
          uid = p["personId"]
          prob = p["confidence"]

          puts "#{(prob * 100).to_i}% - #{uid}"
          
          if prob > 0.5
            cu = CourseUser.where(:uid => uid).first
            t.update(:user_id => cu.user_id) unless cu.nil?
          end
        end
      end
    end
  end

  def detect
		pwidth = self.width.to_f
		pheight = self.height.to_f

    img_url = self.attachment_url

    f = MSCognitive::Face.new
    res = f.detect(img_url)
    faces = JSON.parse(res.body)
    logger.info faces
    faces.each do |face|
      fid = face["faceId"]
      pos = face["faceRectangle"]
      top = (pos["top"] / pheight) * 100
      left = (pos["left"] / pwidth) * 100
      width = (pos["width"] / pwidth) * 100
      height = (pos["height"] / pheight) * 100

			#puts "#{post} #{top}, #{left}, #{width}, #{height}"

      unless t = self.tagged_users.where(:x => left, :y => top, :width => width, :height => height).first
        t = self.tagged_users.new(
          :x => left,
          :y => top,
          :width => width,
          :height => height,
          :fid => fid
        )
        t.save
      end
    end
  end
end
