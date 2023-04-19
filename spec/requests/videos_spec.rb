require 'rails_helper'

RSpec.describe "Videos", type: :request do
  describe "GET /new" do
    context 'when display_id is missing' do
      it "should render NavigateFormComponent" do
        expect(Video::NavigateFormComponent).to receive(:new).once.and_call_original
        expect(Video::DownloadFormComponent).not_to receive(:new)

        get "/videos/new", params: {}

        expect(response.status).to eq 200
        expect(response).to render_template 'videos/new'

        expect(assigns(:video).display_id).to be_nil
      end
    end

    context 'when display_id is given' do
      it "should render DownloadFormComponent" do
        expect(Video::DownloadFormComponent).to receive(:new).once.and_call_original
        expect(Video::NavigateFormComponent).not_to receive(:new)

        get "/videos/new", params: { display_id: 123456789 }

        expect(response.status).to eq 200
        expect(response).to render_template 'videos/new'

        expect(assigns(:video).display_id).to eq '123456789'
      end
    end
  end

  describe "POST /go_to_watch" do
    let(:params) do
      {
        video: { display_id: display_id }
      }
    end

    context 'when display_id is invalid' do
      let(:display_id) { SecureRandom.hex(8) }

      it 'should render NavigateFormComponent' do
        expect(Video::NavigateFormComponent).to receive(:new).once.and_call_original

        post '/videos/go_to_watch.turbo_stream', params: params

        expect(response.status).to eq 200
        expect(response.body).to include 'Invalid id'
      end
    end

    context 'when display_id is valid' do
      let(:display_id) { SecureRandom.hex(5) }

      it 'should display redirect turbo-frame' do
        expect(Video::NavigateFormComponent).not_to receive(:new)

        post '/videos/go_to_watch.turbo_stream', params: params

        expect(response.status).to eq 200
        expect(response.body).to include '<turbo-frame id="redirect"><div data-controller="shared--redirect" data-url="/watch?v=' + display_id + '"></div></turbo-frame>'
      end
    end
  end
end
