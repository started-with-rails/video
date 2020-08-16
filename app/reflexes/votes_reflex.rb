# frozen_string_literal: true

class VotesReflex < ApplicationReflex
  delegate :current_user, to: :connection
  delegate :render, to: ApplicationController
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
    id =  element.dataset[:id].to_i
    @video = VideoItem.find(id)
  end

  def render_data
    morph  dom_id(@video), ApplicationController.render(partial: "home/votes", locals: {video: @video})
  end

end
