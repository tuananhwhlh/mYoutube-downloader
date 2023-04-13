class ApplicationController < ActionController::Base
  before_action :initialize_current_user
  skip_before_action :verify_authenticity_token

  protected

  def initialize_current_user
    return unless user_signed_in?

    Current.current_user = current_user
  end
end
