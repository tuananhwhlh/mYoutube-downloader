require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '.associations' do
    it { is_expected.to belong_to(:videoable) }
  end

  describe '.validations' do
    it { is_expected.to validate_presence_of(:display_id) }
    it { is_expected.to validate_length_of(:display_id).is_at_most(11).with_message('Invalid id') }
  end

  context '.display_id=' do
    it 'should take only id after `?v=` param' do
      video = Video.new(display_id: 'youtube.com/watch?v={youtube-video-id}')

      expect(video.display_id).to eq '{youtube-video-id}'
    end
  end
end
