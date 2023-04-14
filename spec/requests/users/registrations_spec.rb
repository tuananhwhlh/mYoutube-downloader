require 'rails_helper'

RSpec.describe "Users::RegistrationsController", type: :request do
  describe "POST /create" do
    context 'when params is invalid' do
      it "failed to create new user" do
        expect {
          post '/users', params: {}
        }.not_to change(User, :count)

        expect(response.status).to eq 422
        expect(response).to render_template :new
      end
    end

    context 'when params is valid' do
      let(:params) do
        {
          user: {
            email: 'email.test@mYoutube-downloader-test.com',
            first_name: 'FN',
            last_name: 'LN',
            password: 'Pass!2345678*',
            password_confirmation: 'Pass!2345678*'
          }
        }
      end

      it "should redirect to root path after user is created" do
        expect {
          post '/users', params: params
        }.to change(User, :count).by(1)

        expect(response.status).to eq 303
        expect(response).to redirect_to root_path
      end
    end
  end
end
