require 'net/http'

class DownloadJob < ApplicationJob
  queue_as :default

  def perform(data)
    user_id = data[:user_id]
    photos = data[:photos]

    photos.each do |photo|
      pid = photo[:id]
      url = photo[:url]

      Face.download(user_id, url, pid)
    end
  end
end
