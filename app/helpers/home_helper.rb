module HomeHelper
    def video_preview_image(video,size=nil)
        ThumbnailGenerateService.new(video,size).call
    end

    def listing_preview_image(slug)
        resource = Resource.find_by_slug(slug)
        video_preview_image(resource)
    end

    def listing_views_count(slug)
        resource = Resource.find_by_slug(slug)
        video_views_count(resource)
    end

    def video_views_count(video)
        video.impressions.select(:ip_address).distinct.count
    end

    def video_created_time(video)
        video.created_at.strftime("%B %d, %Y")
    end

    def default_image
    end
end