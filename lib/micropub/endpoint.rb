require 'absolutely'
require 'addressable/uri'
require 'http'
require 'nokogiri'

require 'micropub/endpoint/version'
require 'micropub/endpoint/error'
require 'micropub/endpoint/client'
require 'micropub/endpoint/discover'
require 'micropub/endpoint/response'

module Micropub
  module Endpoint
    def self.discover(url)
      Client.new(url).endpoint
    end
  end
end
