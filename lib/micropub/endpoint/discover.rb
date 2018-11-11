module Micropub
  module Endpoint
    class Discover
      # Ultra-orthodox pattern matching allowed values in HTTP Link header `rel` parameter
      # https://tools.ietf.org/html/rfc8288#section-3.3
      REGEXP_REG_REL_TYPE_PATTERN = '[a-z\d][a-z\d\-\.]*'.freeze

      # Liberal pattern matching a string of text between angle brackets
      # https://tools.ietf.org/html/rfc5988#section-5.1
      REGEXP_TARGET_URI_PATTERN = /^<(.*)>;/.freeze

      # Ultra-orthodox pattern matching HTTP Link header `rel` parameter including a `micropub` value
      # https://www.w3.org/TR/micropub/#endpoint-discovery
      REGEXP_MICROPUB_REL_PATTERN = /(?:;|\s)rel="?(?:#{REGEXP_REG_REL_TYPE_PATTERN}+\s)?micropub(?:\s#{REGEXP_REG_REL_TYPE_PATTERN})?"?/.freeze

      def initialize(response)
        raise ArgumentError, "response must be an HTTP::Response (given #{response.class.name})" unless response.is_a?(HTTP::Response)

        @response = response
      end

      def endpoint
        return unless endpoint_from_http_request

        @endpoint ||= Absolutely.to_absolute_uri(base: @response.uri.to_s, relative: endpoint_from_http_request)
      rescue Absolutely::InvalidURIError => error
        raise InvalidURIError, error
      end

      private

      def endpoint_from_body
        return unless @response.mime_type == 'text/html'

        doc = Nokogiri::HTML(@response.body.to_s)

        # Search response body for first `link` element with valid `rel` attribute
        link_element = doc.css('link[rel~="micropub"][href]').shift

        return link_element['href'] if link_element
      end

      def endpoint_from_headers
        link_headers = @response.headers.get('link')

        return unless link_headers

        # Split Link headers with multiple values, flatten the resulting array, and strip whitespace
        link_headers = link_headers.map { |header| header.split(',') }.flatten.map(&:strip)

        micropub_header = link_headers.find { |header| header.match?(REGEXP_MICROPUB_REL_PATTERN) }

        return unless micropub_header

        endpoint_match_data = micropub_header.match(REGEXP_TARGET_URI_PATTERN)

        return endpoint_match_data[1] if endpoint_match_data
      end

      def endpoint_from_http_request
        @endpoint_from_http_request ||= endpoint_from_headers || endpoint_from_body || nil
      end
    end
  end
end
