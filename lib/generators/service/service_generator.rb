class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  argument :methods, type: :array, default: [], banner: "method method"

  def create_service_file
    return unless class_name.present?

    @module_names = class_name.split('::')[..-2]    

    template "service.erb", create_folders_and_return_generator_path("app/services")
  end

  def create_service_spec_file
    return unless class_name.present?

    template "service_spec.erb", create_folders_and_return_generator_path("spec/services")
  end

  private

  def create_folders_and_return_generator_path(dir_path)
    Dir.mkdir(dir_path) unless File.exist?(dir_path)

    generator_dir_path = dir_path

    @module_names.each do |module_name|
      generator_dir_path += "/#{module_name.underscore}"

      Dir.mkdir(generator_dir_path) unless File.exist?(generator_dir_path)
    end

    generator_dir_path + "/#{file_name + (dir_path.include?('spec/') ? '_spec' : '')}.rb"
  end
end
