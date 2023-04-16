# frozen_string_literal: true

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers,      type: :component
  config.include Capybara::RSpecMatchers,         type: :component
  config.include ActionView::Helpers::FormHelper, type: :component
  config.include ActionView::TestCase::Behavior,  type: :component

  def test_app_host
    Rails.application.routes.default_url_options[:host]
  end
end
