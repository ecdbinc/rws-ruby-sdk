if ENV['CI']
  require 'simplecov'

  SimpleCov.start do
    skip "/spec/"
  end
end

require File.expand_path(File.join(__dir__, '..', 'lib', 'rakuten_web_service'))

require 'webmock/rspec'

Dir[File.expand_path(File.join(__dir__, "support/**/*.rb"))].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run_excluding type: 'integration' if ENV['INTEGRATION'] != 'yes'

  config.before :suite do
    WebMock.disable_net_connect!
  end

  config.before :all, type: 'integration' do
    WebMock.allow_net_connect!
    RakutenWebService.configure do |c|
      c.application_id = ENV['RWS_APPLICATION_ID']
    end
  end

  config.after :each do
    WebMock.reset!
  end
end
