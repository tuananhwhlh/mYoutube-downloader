# frozen_string_literal: true

class Shared::NavbarComponent < ApplicationComponent
  def menu_options
    [
      {
        text: t('components.dashboard'),
        href: root_path
      },
      {
        text: t('components.videos'),
        hidden: !current_user
      }
    ]
  end

  def user_profile_options
    [
      {
        text: t('components.hi_to_someone', name: current_user&.first_name),
        hidden: !current_user
      },
      {
        text: t('components.settings')
      },
      {
        text: t('components.sign_out'),
        href: destroy_user_session_path,
        hidden: !current_user,
        data: {
          turbo_method: :delete,
          turbo_confirm: 'Are you sure?'
        }
      },
      {
        text: t('components.sign_in'),
        href: new_user_session_path,
        hidden: current_user,
        data: {
          turbo: false
        }
      }
    ]
  end
end
