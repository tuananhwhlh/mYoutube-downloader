# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, timecop: true) do |example|
    Timecop.freeze(example.metadata[:timecop])
  end

  config.after(:each, timecop: true) do
    Timecop.return
  end
end
