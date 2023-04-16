# frozen_string_literal: true

require "rails_helper"

RSpec.describe Shared::DropdownComponent, type: :component do
  describe '#render_inline', timecop: Time.zone.local(2023, 4, 8, 12, 30, 0) do
    let(:options) do
      {
        text: 'Dropdown',
        button_css_class: 'flex rounded-full bg-gray-800 text-sm',
        svg_path: 'svg/user-circle',
        svg_css_class: 'stroke-gray-400 h-7 w-7',
        items: [
          {
            text: "Hello world!",
            hidden: false
          },
          {
            text: 'Hidden option',
            hidden: true
          },
          {
            text: 'Home',
            href: test_app_host,
            data: {
              turbo_method: :get
            }
          }
        ]
      }
    end

    subject { described_class.new(**options) }

    it 'renders component' do
      allow_any_instance_of(described_class).to receive(:rand).with(Time.current.to_i).and_return 89

      render_inline subject

      button = page.find("button[data-dropdown-toggle='dropdownMenu89']")

      expect(button['class']).to eq 'flex rounded-full bg-gray-800 text-sm'
      expect(button['data-dropdown-offset-skidding']).to eq '0'
      expect(button.text).to include 'Dropdown'
      expect(button).to have_selector('svg.stroke-gray-400.h-7.w-7')

      dropdown_meu = page.find("div[id='dropdownMenu89']")

      option1, option2 = dropdown_meu.find_all('li').to_a

      expect(option1.text).to include 'Hello world!'
      expect(option1.find('a')['href']).to eq 'javascript:void(0)'

      expect(option2.text).to include 'Home'
      expect(option2.find('a')['href']).to eq test_app_host
    end
  end
end
