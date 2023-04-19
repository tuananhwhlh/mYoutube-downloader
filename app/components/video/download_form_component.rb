# frozen_string_literal: true

class Video::DownloadFormComponent < ApplicationComponent
  def initialize(resource:)
    @resource = resource
  end

  attr_reader :resource
end
