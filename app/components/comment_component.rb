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
    comment.user.try(:name)
  end

  def avatar
    comment.user.avatar.attached? ? comment.user.avatar.variant(resize_to_limit: [50,50]).processed : 'user.png'
  end
end
