# frozen_string_literal: true

class Video::NavigateFormComponent < ApplicationComponent
  def initialize(resource:)
    @resource = resource
  end

  attr_reader :resource

  def demo_path
    @demo_path ||= "watch?v={youtube-video-id}"
  end
end
