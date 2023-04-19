require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#svg_icon' do
    it 'renders svg tag' do
      svg_content = <<~HTML
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewbox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M9 8.25H7.5a2.25 2.25 0 00-2.25 2.25v9a2.25 2.25 0 002.25 2.25h9a2.25 2.25 0 002.25-2.25v-9a2.25 2.25 0 00-2.25-2.25H15M9 12l3 3m0 0l3-3m-3 3V2.25"></path></svg>
      HTML

      expect(helper.svg_icon('svg/arrow-down-on-square')).to eq svg_content.squish
    end

    it 'renders svg tag with given CSS classes' do
      svg_content = <<~HTML
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewbox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-8 h-8"><path stroke-linecap="round" stroke-linejoin="round" d="M9 8.25H7.5a2.25 2.25 0 00-2.25 2.25v9a2.25 2.25 0 002.25 2.25h9a2.25 2.25 0 002.25-2.25v-9a2.25 2.25 0 00-2.25-2.25H15M9 12l3 3m0 0l3-3m-3 3V2.25"></path></svg>
      HTML

      expect(helper.svg_icon('svg/arrow-down-on-square', class: 'w-8 h-8')).to eq svg_content.squish
    end
  end

  describe '#redirect_tag' do
    it 'renders redirect_tag' do
      expect(
        helper.redirect_tag('/root', 'redirect')
      ).to eq '<turbo-frame id="redirect"><div data-controller="shared--redirect" data-url="/root"></div></turbo-frame>'
    end
  end

  describe '#required_label' do
    it 'renders label tag' do
      expect(
        helper.required_label('Text')
      ).to eq "Text <abbr title='required'>*</abbr>"
    end
  end
end
