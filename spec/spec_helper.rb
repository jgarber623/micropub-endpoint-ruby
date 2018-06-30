require 'simplecov'
require 'webmock/rspec'

require 'micropub/endpoint'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

Dir.glob(File.join(Dir.pwd, 'spec', 'support', '**', '*.rb')).sort.each { |f| require f }

RSpec.configure do |config|
  config.include FixtureHelpers
end
