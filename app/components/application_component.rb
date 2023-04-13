# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  include ApplicationHelper

  delegate :current_user, to: Current

  def admin?
    current_user.admin?
  end
end
