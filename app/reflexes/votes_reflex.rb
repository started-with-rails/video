# frozen_string_literal: true

class VotesReflex < ApplicationReflex
 
  before_reflex :set_video


  def upvote 
    @video.upvote_by current_user
    render_data
  end  
  
  def downvote
    @video.downvote_by current_user
    render_data
  end

  private

  def set_video
    @video = GlobalID::Locator.locate_signed(element.dataset.signed_id)
  end

  def render_data
    morph  dom_id(@video), ApplicationController.render(partial: "home/votes", locals: {video: @video})
  end

end
