class Resource < ApplicationRecord
    include FriendlyUrl
    has_and_belongs_to_many :categories
    belongs_to :user
    enum type: { source_file: "Upload File", video_url: "Video URL", embed_code: "Embed Code" }
    attr_accessor :thumbnail_option
    has_one_attached :source_file
    has_one_attached :source_thumbnail
end
