class VideoItemsController < ApplicationController
    before_action :authenticate_user!
    def new
        @video = VideoItem.new
    end

    def create
    @video =  current_user.video_items.build(video_params)
      respond_to do |format|
        if @video.save
            format.html { redirect_to root_path, notice: 'video was successfully created.' }
            format.json { render :show, status: :created, location: @video }
        else
            format.html { render :new }
            format.json { render json: @video.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def video_params
        params.require(:video_item).permit(:title,:slug,:allow_download,:auto_play,:excerpt,:description,:video_type, :video_url, :accepted_terms_and_conditions,:embed_code,:user_id,:status,:featured,:thumbnail_option,:video_file,:video_thumbnail, category_ids: [])
    end
end
