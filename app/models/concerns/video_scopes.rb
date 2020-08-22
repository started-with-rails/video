module VideoScopes
    extend ActiveSupport::Concern
    included do
        scope :recent, -> { order(created_at: :desc)}
        scope :active, -> { where(status: true)}
        scope :featured, -> { where(featured: true).active}
        scope :embed_videos, -> { where(video_type: 'embed_code') }
        scope :source_videos, -> { where(video_type: 'source_file') }
        scope :url_videos, -> { where(video_type: 'video_url') }

        scope :latest_videos, -> {  with_attachments.featured.recent}
        scope :most_viewed, -> { with_attachments.order(impressions_count: :desc) }
        scope :most_rated, -> { with_attachments.order(cached_votes_up:  :desc) }
        scope :most_commented, -> { with_attachments.joins(:comments).group("video_items.id").order("count(video_items.id) DESC") }
        scope :popular_videos, -> { with_attachments.order(cached_weighted_average: :desc) }
        
        scope :similar_categories_videos, -> (video) do
            joins(:categories).where(categories: { id: video.category_ids.uniq }).recent.distinct.with_attachments.limit(6)
        end

        scope :banner_videos, -> do
            with_attachments.latest_videos.embed_videos
        end

        scope :with_attachments, -> { includes(video_file_attachment: :blob, video_thumbnail_attachment: :blob) }

    end
end