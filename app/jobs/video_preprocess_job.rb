class VideoPreprocessJob < ApplicationJob
    queue_as :default
  
    def perform(video)
        thumb = video.video_file.preview(resize_to_limit: [200,200]).processed
        file_path = ENV['BASE_DOMAIN'].to_s + Rails.application.routes.url_helpers.rails_representation_url(thumb, only_path: true).to_s
        video.video_thumbnail.attach(io: open(file_path), filename: 'video_thumbnail.jpg', content_type: 'image/jpg')
    end
end