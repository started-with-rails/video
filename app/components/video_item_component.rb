class VideoItemComponent < ViewComponent::Base
    with_collection_parameter :video
    include ViewComponent::Slotable
    with_slot  :list
    attr_reader :video, :category

    def initialize(video:, category: :nil)
      @video = video
      @category = category
    end

    def slug
        video.try(:slug)
    end

    def title
        video.try(:title)
    end

    def video_views_count
        video.impressions.select(:ip_address).distinct.count
    end

    def created_date
        video.created_at.strftime("%B %d, %Y")
    end

    def video_preview_image
        ThumbnailGenerateService.new(video).call
    end

    def category_title
        category.try(:title)
    end

    def category_slug
        category.try(:slug)
    end

    def html_ele
     list ? 'li' : 'div'
    end
end
