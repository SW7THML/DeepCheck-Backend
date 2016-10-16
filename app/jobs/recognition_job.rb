class RecognitionJob < ApplicationJob
  queue_as :default

  def perform(data)
    p = Photo.find(data[:photo_id])
    # save image size
    puts "get size"
    p.get_size
    # detect
    puts "detect"
    p.detect
    # identify
    puts "identify"
    p.identify
  end
end
