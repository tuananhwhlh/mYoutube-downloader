class VideosController < ApplicationController
  before_action :init_video

  def new
    @video.display_id = params[:display_id]
  end

  def go_to_watch
    video_params = params.require(:video).permit(:display_id)

    @video.display_id = video_params[:display_id]
    @video.valid?

    @invalid_id = @video.errors.include?(:display_id)
  end

  def download
    
  end

  private

  def init_video
    @video ||= Video.new
  end
end
