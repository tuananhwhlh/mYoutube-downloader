module ApplicationHelper
  include Turbo::StreamsHelper
  include Turbo::FramesHelper

  def svg_icon(filename, **options)
    file = File.read(Rails.root.join('app', 'assets', "#{filename}.svg"))
    doc  = Nokogiri::HTML::DocumentFragment.parse file
    svg  = doc.at_css 'svg'

    options.each { |attr, value| svg[attr.to_s] = value }
    doc.to_html
  end

  def redirect_tag(url, frame)
    turbo_frame_tag(frame) do
      content_tag :div, nil, data: { controller: 'shared--redirect', url: url }
    end
  end

  def required_label(text)
    "#{text} <abbr title='required'>*</abbr>".html_safe
  end
end
