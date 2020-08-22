# frozen_string_literal: true

class CommentReflex < ApplicationReflex
  before_reflex :find_commentable

  def submit
    @comment = @commentable.comments.new
    @comment.assign_attributes(comment_params)
    @comment.user = current_user
    @comment.save
    morph  dom_id(@commentable), ApplicationController.render(partial: "home/votes", locals: {video: @commentable})
    morph  "#video_comments_#{@commentable.id}", ApplicationController.render(partial: "home/comments", locals: {video: @commentable, comment: @comment})
  end

  private

  def find_commentable
    @commentable = GlobalID::Locator.locate_signed(element.dataset.signed_id)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
