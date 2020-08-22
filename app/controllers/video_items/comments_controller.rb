class VideoItems::CommentsController < CommentsController
    before_action :set_commentable
  
    private
  
    def set_commentable
        @commentable = VideoItem.find_by(slug: params[:video_item_id])
    end
end