class RecognitionJob < ApplicationJob
  queue_as :urgent

  def perform(data)
    p = Photo.find(data[:photo_id])
    # save image size
    puts "get size"
    logger.info "get size"
    p.get_size
    # detect
    puts "detect"
    logger.info "detect"
    p.detect
    # identify
    puts "identify"
    logger.info "identify"
    p.identify
  end
end
