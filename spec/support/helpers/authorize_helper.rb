module RSpec
  module Support
    module AuthorizeHelper
      def admin_sign_in
        admin.confirm

        sign_in admin
      end
    end
  end
end
