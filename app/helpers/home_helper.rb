module HomeHelper
    
    def video_preview_image(video)
        VideoThumb.new(video).get('max')
    end

    def video_views_count(video)
        video.impressions_count
    end

    def video_created_time(video)
        video.created_at.strftime("%B %d, %Y")
    end

    def get_tab_status(label,tab=nil)
        return 'active' if tab.nil? && label == 'latest' 
        label == tab ? 'active' : ''
    end

    def get_menu_status(action,items)
        items.split(",").include?(action)  ? 'active' : ''
    end

    def default_image
    end
end