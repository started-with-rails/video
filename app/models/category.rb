class Category < ApplicationRecord
  include FriendlyUrl
  scope :active, -> {where(:status => true)}
  has_and_belongs_to_many :video_items
  has_and_belongs_to_many :latest_videos, ->  { latest_videos }, class_name: 'VideoItem'
  # has_and_belongs_to_many :most_viewed_videos, ->  { latest_videos }, class_name: 'VideoItem'
  # has_and_belongs_to_many :most_liked_videos, ->  { latest_videos }, class_name: 'VideoItem'

  scope :active, -> {where(status: true)}
  scope :show_in_home, -> {where(show_in_home_page: true).active }
  scope :order_by_position, -> { order(:position)}
  scope :include_video_items_with_attachments, -> {includes(video_items: [video_file_attachment: :blob, video_thumbnail_attachment: :blob]) }

end
