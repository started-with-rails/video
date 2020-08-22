class VideoItemComponent < ViewComponent::Base
    with_collection_parameter :video
    include ViewComponent::Slotable
    extend Forwardable
    delegate [:title,:slug,:video_type, :excerpt] => :@video
    with_slot  :list
    attr_reader :video, :category

    def initialize(video:, category: :nil)
      @video = video
      @category = category
    end

    def video_views_count
        video.impressions_count
    end

    def created_date
        video.created_at.strftime("%B %d, %Y")
    end

    def video_preview_image
        case video_type
        when 'embed_code'
         EmbedCodeThumbGenerateService.new(video).call
        when 'video_url','video_file'
         ThumbnailGenerateService.new(video).call
        else
          "missing.jpg" 
        end
    end

    def category_title
        category.try(:title)
    end

    def category_slug
        category.try(:slug)
    end

    def comments_count
        video.comments.size
    end

    def html_ele
     list ? 'li' : 'div'
    end
end
