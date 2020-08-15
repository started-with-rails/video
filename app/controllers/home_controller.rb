class HomeController < ApplicationController
  before_action :add_videos_breadcrumb_path, only: [:categories, :video]
  before_action :set_category, only: [:categories, :video]
  
  def index
    @banner_videos = VideoItem.banner_videos
    @latest_videos = VideoItem.latest_videos
    @categories = Category.include_video_items_with_attachments.show_in_home.order_by_position
  end

  def categories
   add_breadcrumb(@category.try(:title))
   @latest_videos = @category.latest_videos.with_attachments
  end

  def video
    add_breadcrumb(@category.try(:title),category_url(category_slug: @category.try(:slug)))
    add_breadcrumb(@video.try(:title))
    # impressionist(@video)
  end

  def videos
  end


  def addvideo
  end

  def search
  end

  private

  def add_videos_breadcrumb_path
    add_breadcrumb('videos', videos_path)
  end

  def set_category
    if params[:category_slug].present?
      @category ||= Category.find_by(slug: params[:category_slug])
    elsif params[:video_slug].present?
      @video ||= VideoItem.find_by_slug(params[:video_slug])
      @category ||=  @video.categories.first
    end
  end

  # def cache_generate(key,value)
  #   Rails.cache.fetch(key, expires_in: 12.hours) do
  #     value
  #   end
  # end
end
