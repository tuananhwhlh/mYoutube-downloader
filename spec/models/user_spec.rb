require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
  end

  describe '.associations' do
    it { is_expected.to have_many(:videos).dependent(:destroy) }
  end
end
