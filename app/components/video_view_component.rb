class VideoViewComponent < ViewComponent::Base
  extend Forwardable
  attr_reader :video
  delegate [:video_file, :slug, :embed_code, :video_url, :video_type] => :@video
 
  def initialize(video:)
    @video = video
  end

end
