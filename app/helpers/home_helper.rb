module HomeHelper
    
    def video_preview_image(video)
        EmbedCodeThumbGenerateService.new(video).call
    end

    def video_views_count(video)
        video.impressions.select(:ip_address).distinct.count
    end

    def video_created_time(video)
        video.created_at.strftime("%B %d, %Y")
    end

    def get_tab_status(label,tab=nil)
        return (label == 'latest' && tab.nil?) ? 'active' : ''
        label == tab ? 'active' : ''
    end

    def default_image
    end
end