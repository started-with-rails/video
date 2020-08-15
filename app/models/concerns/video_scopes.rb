module VideoScopes
    extend ActiveSupport::Concern
    included do
        scope :recent, -> { order(created_at: :desc)}
        scope :active, -> { where(status: true)}
        scope :featured, -> { where(featured: true).active}
        scope :embed_videos, -> { where(video_type: 'embed_code') }
        scope :source_videos, -> { where(video_type: 'source_file') }
        scope :url_videos, -> { where(video_type: 'video_url') }

        scope :latest_videos, -> { featured.recent}
        scope :popular_videos, -> { }
        scope :similar_video, -> (category) do
            
        end

        scope :banner_videos, -> do
            latest_videos.embed_videos
        end

        scope :with_attachments, -> { includes(video_file_attachment: :blob, video_thumbnail_attachment: :blob) }
        

        has_one :most_recent_listing, -> do
            merge(Listing.most_recent_by_video)
          end, class_name: "Listing", inverse_of: :video

    end
end