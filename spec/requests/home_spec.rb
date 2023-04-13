require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /index" do
    context 'when user is not signed in' do
      it "renders root page" do
        get '/'

        expect(response.status).to eq 200
        expect(response).to render_template 'home/index'
        expect(controller.current_user).to be_nil
      end
    end

    context 'when user is signed in' do
      let(:admin) { users(:admin) }

      it "renders root page" do
        admin_sign_in

        get '/'
        expect(response.status).to eq 200
        expect(response).to render_template 'home/index'
        expect(controller.current_user).to eq admin
      end
    end
  end
end
