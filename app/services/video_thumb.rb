class VideoThumb

    attr_reader :video
    
    def initialize(video)
      @video = video
    end

    def get(size='large')
      get_thumbnail_url size
    end

    private

    def get_thumbnail_url size
      return get_video_thumbnail if video.try(:video_thumbnail).attached?
      image = case video.try(:video_type)
      when 'video_file'
        get_thumbnail_from_video_file
      when 'video_url'
        get_video_thumbnail
      when 'embed_code'
        EmbedVideoThumb.new.get(video.try(:embed_code), size)
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