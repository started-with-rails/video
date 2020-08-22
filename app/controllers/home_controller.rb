class HomeController < ApplicationController
  before_action :add_videos_breadcrumb_path, only: [:categories, :video]
  before_action :set_category, only: [:categories, :video]
  before_action :set_categories
  
  def index
    @banner_videos = VideoItem.banner_videos.limit(6)
    @latest_videos = VideoItem.latest_videos.limit(9)
    @popular_videos = VideoItem.popular_videos.limit(6)
     end

  def categories
   tab = params[:tab] || 'latest'
   videos = case tab
   when  'most_viewed'
    @category.most_viewed_videos
   when 'most_commented'
    @category.most_commented_videos
   when 'latest'
     @category.latest_videos
   end
   @videos = videos.with_attachments.page(params[:page]).per(2)
   add_breadcrumb(@category.try(:title))
  end

  def video
    @similar_videos = Rails.cache.fetch("#{@video.updated_at.to_i}", expires_in: 1.hour) do
      VideoItem.similar_categories_videos(@video)
    end
    add_breadcrumb(@category.try(:title),category_url(category_slug: @category.try(:slug)))
    add_breadcrumb(@video.try(:title))
    impressionist(@video, "some message", :unique => [:session_hash])
  end

  def videos
    tab = params[:tab] || 'latest'
    videos = case tab
    when  'most_viewed'
      VideoItem.most_viewed
    when 'most_commented'
      VideoItem.most_commented
    when 'latest'
      VideoItem.latest_videos
    end
    @videos = videos.page(params[:page]).per(3)
    add_breadcrumb(tab)
  end

  def search
    videos = VideoItem.search(params[:q])
    tab = params[:tab] || 'latest'
    videos = case tab
    when  'most_viewed'
      videos.most_viewed
    when 'most_commented'
      videos.most_commented
    when 'latest'
      videos.latest_videos
    end
    @videos = videos.page(params[:page]).per(3)
  end

  def addvideo
  end

  def about_us
    add_breadcrumb('About Us')
  end

  def blog
    add_breadcrumb('Blog')
  end

  def faqs
    add_breadcrumb('Faqs')
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

  def set_categories
    @categories = Rails.cache.fetch("#{Category.show_in_home.last.updated_at.to_i}", expires_in: 12.hours) do
      Category.include_video_items_with_attachments.show_in_home.order_by_position.limit(6)
    end
  end
 
  # def cache_generate(key,value)
  #   Rails.cache.fetch(key, expires_in: 12.hours) do
  #     value
  #   end
  # end
end
