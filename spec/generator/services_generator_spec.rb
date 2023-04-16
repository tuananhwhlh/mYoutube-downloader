require 'rails_helper'
require 'rails/generators'

RSpec.describe 'Service', type: :generator do
  include FileUtils

  let(:dummy_service_file) { Rails.root.join('app/services', 'dummy_module', "test_service.rb") }
  let(:dummy_service_spec_file) { Rails.root.join('spec/services', 'dummy_module', "test_service_spec.rb") }

  let(:service_template) do
    <<-CONTENT
      class DummyModule::TestService < ApplicationService
        def initialize

        end

        def perform

        rescue StandardError
          false
        end

        private 

        def method1

        end

        def method2

        end

      end
    CONTENT
  end

  let(:service_spec_template) do
    <<-CONTENT
      require 'rails_helper'

      RSpec.describe DummyModule::TestService, type: :service do

      end
    CONTENT
  end

  before do
    Rails::Generators.invoke("service", ['DummyModule::TestService', ['method1', 'method2']])
  end

  it 'should create service file and spec file with given templates' do
    expect(File.read(dummy_service_file).squish).to include service_template.squish
    expect(File.read(dummy_service_spec_file).squish).to include service_spec_template.squish

    rm_rf(dummy_service_file) if File.exists? dummy_service_file
    rm_rf(dummy_service_spec_file) if File.exists? dummy_service_spec_file
  end
end
