# frozen_string_literal: true

class ApplicationService
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  delegate :current_user, to: Current
end
