class HomeController < ApplicationController
  
  def index
    @listings = Listing.home_view_listing
    @banner_videos = Resource.banner_videos
    @latest_videos = Resource.latest_videos
    @categories = Category.show_in_home.order_by_position
  end

  def categories
  end

  def video
    @resource = Resource.find_by_slug(params[:video_slug])
    impressionist(@resource)
  end

  def single
  end

  def addvideo
  end

  def search
  end
end
