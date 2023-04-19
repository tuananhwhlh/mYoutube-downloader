# frozen_string_literal: true

require "rails_helper"

RSpec.describe Video::NavigateFormComponent, type: :component do
  describe '#render_inline' do
    let(:resource) { Video.new }

    subject { described_class.new(resource: resource) }

    context 'when the resource has failed validation' do
      it 'renders component' do
        resource.display_id = SecureRandom.hex(8)
        resource.valid?

        render_inline subject

        form = page.find("turbo-frame[id='video-form']").find('form')

        expect(form['action']).to eq go_to_watch_videos_path

        input = form.find("input[name='video[display_id]']")
        expect(input['value']).to eq resource.display_id
        expect(input['placeholder']).to eq 'youtube.com/watch?v={youtube-video-id} or {youtube-video-id}'
        expect(form.find("div[class='error-message']").text).to include 'Invalid id'
      end
    end

    context 'when first rendering' do
      it 'renders component' do
        render_inline subject

        form = page.find("turbo-frame[id='video-form']").find('form')

        expect(form['action']).to eq go_to_watch_videos_path

        input = form.find("input[name='video[display_id]']")
        expect(input['value']).to be_nil
        expect(input['placeholder']).to eq 'youtube.com/watch?v={youtube-video-id} or {youtube-video-id}'
        expect(form).not_to have_selector("div[class='error-message']")
      end
    end
  end
end
