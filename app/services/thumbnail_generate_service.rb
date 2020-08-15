class ThumbnailGenerateService
    attr_reader :video
   
    def initialize(video)
      @video = video
    end

    def call
        get_thumbnail_url
    end

    private

    def get_thumbnail_url
      return get_video_thumbnail if video.try(:video_thumbnail).attached?
      case video.try(:video_type)
      when 'video_file'
        get_thumbnail_from_video_file
      when 'video_url'
        get_video_thumbnail
      else
        "missing.jpg"
      end
      rescue => e
        "missing.jpg"
    end

    def get_video_thumbnail
      video.video_thumbnail.variant(resize_to_limit: [200,200]).processed
    end

    def get_thumbnail_from_video_file
      video.video_file.preview(resize_to_limit: [200,200]).processed
    end

end