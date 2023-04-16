# frozen_string_literal: true

require "rails_helper"

RSpec.describe Shared::NavbarComponent, type: :component do
  describe '#render_inline' do
    subject { described_class.new }

    before do
      Current.current_user = user
    end

    context 'menu options' do
      context 'when user is not signed in' do
        let(:user) { nil }

        it 'renders component' do
          render_inline subject

          non_mobile_wrapper = page.find('div.flex.space-x-4')
          option = non_mobile_wrapper.find('a')
          expect(option.text).to include I18n.t('components.dashboard')
          expect(option['href']).to eq root_path

          mobile_wrapper = page.find('div.space-y-1.px-2.pb-3.pt-2')
          option = mobile_wrapper.find('a')
          expect(option.text).to include I18n.t('components.dashboard')
          expect(option['href']).to eq root_path
        end
      end

      context 'when user is signed in' do
        let(:user) { users(:admin) }

        it 'renders component' do
          render_inline subject

          non_mobile_wrapper = page.find('div.flex.space-x-4')
          option1, option2 = non_mobile_wrapper.find_all('a').to_a

          expect(option1.text).to include I18n.t('components.dashboard')
          expect(option1['href']).to eq root_path
          expect(option2.text).to include I18n.t('components.videos')
          expect(option2['href']).to eq '#'

          mobile_wrapper = page.find('div.space-y-1.px-2.pb-3.pt-2')
          option1, option2 = non_mobile_wrapper.find_all('a').to_a

          expect(option1.text).to include I18n.t('components.dashboard')
          expect(option1['href']).to eq root_path
          expect(option2.text).to include I18n.t('components.videos')
          expect(option2['href']).to eq '#'
        end
      end
    end

    context 'user profile options' do
      before do
        allow_any_instance_of(Shared::DropdownComponent).to receive(:rand).with(Time.current.to_i).and_return 89
      end

      context 'when user is not signed in' do
        let(:user) { nil }

        it 'renders component' do
          render_inline subject

          dropdown_meu = page.find("div[id='dropdownMenu89']")
          option1, option2 = dropdown_meu.find_all('li').to_a

          expect(option1.text).to include I18n.t('components.settings')
          expect(option1.find('a')['href']).to eq 'javascript:void(0)'

          expect(option2.text).to include I18n.t('components.sign_in')
          expect(option2.find('a')['href']).to eq new_user_session_path
          expect(option2.find('a')['data-turbo']).to eq 'false'
        end
      end

      context 'when user is signed in' do
        let(:user) { users(:admin) }

        it 'renders component' do
          render_inline subject

          dropdown_meu = page.find("div[id='dropdownMenu89']")
          option1, option2, option3 = dropdown_meu.find_all('li').to_a

          expect(option1.text).to include I18n.t('components.hi_to_someone', name: user.first_name)
          expect(option1.find('a')['href']).to eq 'javascript:void(0)'

          expect(option2.text).to include I18n.t('components.settings')
          expect(option2.find('a')['href']).to eq 'javascript:void(0)'

          expect(option3.text).to include I18n.t('components.sign_out')
          expect(option3.find('a')['href']).to eq destroy_user_session_path
          expect(option3.find('a')['data-turbo-method']).to eq 'delete'
          expect(option3.find('a')['data-turbo-confirm']).to eq 'Are you sure?'
        end
      end
    end
  end
end
