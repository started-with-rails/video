class VideoItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_video, only: [:upvote,:downvote]
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

    def upvote 
      @video.upvote_by current_user
      redirect_to :back
    end  
    
    def downvote
      @video.downvote_by current_user
      redirect_to :back
    end


    private

    def set_video
      @video = VideoItem.find(params[:id])
    end

    def video_params
        params.require(:video_item).permit(:title,:slug,:allow_download,:auto_play,:excerpt,:description,:video_type, :video_url, :accepted_terms_and_conditions,:embed_code,:user_id,:status,:featured,:thumbnail_option,:video_file,:video_thumbnail, category_ids: [])
    end
end
