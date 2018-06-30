require 'micropub/endpoint/version'

module Micropub
  module Endpoint
    def self.discover(url)
      Discover.new(url).endpoint
    end
  end
end
