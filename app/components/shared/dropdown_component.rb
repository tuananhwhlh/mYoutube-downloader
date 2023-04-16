# frozen_string_literal: true

class Shared::DropdownComponent < ApplicationComponent
  def initialize(**options)
    @options = options.presence || {}

    read_options
  end

  attr_reader :options,
              :items,
              :text,
              :svg_path,
              :button_css_class,
              :svg_css_class,
              :dropdown_id

  def read_options
    @items = options.fetch(:items, [])
    @text = options.fetch(:text, nil)
    @svg_path = options.fetch(:svg_path, 'svg/chevron-down')
    @svg_css_class = options.fetch(:svg_css_class, 'h-5 w-5 ml-2')
    @button_css_class = options.fetch(:button_css_class, default_button_css_class)
    @menu_css_class = options.fetch(:menu_css_class, default_menu_css_class)
    @dropdown_id = options.fetch(:dropdown_id, "dropdownMenu#{rand(Time.current.to_i)}")
  end

  private

  def default_button_css_class
    "text-white bg-blue-700 hover:bg-blue-800 focus:outline-none font-medium rounded-lg text-sm px-2.5 py-2 text-center inline-flex items-center dark:bg-blue-600 dark:hover:bg-blue-700"
  end

  def default_menu_css_class
    "z-10 hidden bg-white rounded-lg shadow w-44"
  end
end
