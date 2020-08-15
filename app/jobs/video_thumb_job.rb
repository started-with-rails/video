class VideoThumbJob < ApplicationJob
    queue_as :default
  
    def perform(video)
        case video.video_type
        when 'video_file'
            generate_thumb_from_file(video)
        when 'video_url'
            generate_thumb_from_url(video)
        end
    end

    private
    
    def generate_thumb_from_file(video)
        thumb = video.video_file.preview(resize_to_limit: [200,200]).processed
        file_path = ENV['BASE_DOMAIN'].to_s + Rails.application.routes.url_helpers.rails_representation_url(thumb, only_path: true).to_s
        video.video_thumbnail.attach(io: File.open(file_path), filename: "#{video.try(:slug)}.jpg", content_type: 'image/jpg')
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            Rails.logger.info "Error : Thumbnail failed for  video #{video.title}"
        ensure
            File.delete(file_path) if File.exist?(file_path)
    end

    def generate_thumb_from_url(video)
        target_path = Rails.root.join("storage/uploads/tmp/#{video.slug}.jpg").to_s
        target_path_name = Pathname.new(target_path)
        target_path_name.dirname.mkpath unless File.directory?(target_path_name.dirname)
        status = %x[ffmpeg -y -i #{video.video_url} -ss 00:00:00.500 -vframes 1 -an -vf "scale=w=650:h=400:force_original_aspect_ratio=decrease" #{target_path}]
        video.video_thumbnail.attach(io: File.open(target_path_name), filename: "#{video.try(:slug)}.jpg", content_type: 'image/jpg')
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            Rails.logger.info "Error : Thumbnail failed for  video #{video.title}"
        ensure
            File.delete(target_path) if File.exist?(target_path)
    end
end