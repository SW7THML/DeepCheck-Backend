class RecognitionJob < ApplicationJob
  queue_as :default

  def perform(data)
    p = Photo.find(data[:photo_id])
    # save image size
    p.get_size
    # detect
    p.detect
    # identify
    p.identify
  end
end
