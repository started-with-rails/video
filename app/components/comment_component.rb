class CommentComponent < ViewComponent::Base
  with_collection_parameter :comment
  extend Forwardable
  delegate [:id,:content] => :@comment
  attr_reader :comment
 
  def initialize(comment:)
    @comment = comment
  end

  def created_time
    comment.created_at.strftime("%B %d, %Y - %H:%M%P")
  end

  def user
    comment.user.email
  end
end
