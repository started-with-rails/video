class RecentCommentsComponent < ViewComponent::Base
    with_collection_parameter :comment
    attr_reader :comment
   
    def initialize(comment:)
      @comment = comment
    end
  
    def video_title
      comment.commentable.try(:title)
    end
  
    def comment_user
      comment.user.email
    end
end
