require 'absolutely'
require 'addressable/uri'
require 'http'
require 'nokogiri'

require 'micropub/endpoint/version'
require 'micropub/endpoint/error'
require 'micropub/endpoint/discover'

module Micropub
  module Endpoint
    def self.discover(url)
      Discover.new(url).endpoint
    end
  end
end
