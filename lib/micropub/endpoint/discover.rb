module Micropub
  module Endpoint
    class Discover
      HTTP_HEADERS_OPTS = {
        accept: '*/*',
        user_agent: 'Micropub Endpoint Discovery (https://rubygems.org/gems/micropub-endpoint)'
      }.freeze

      # Ultra-orthodox pattern matching allowed values in Link header `rel` parameter
      # https://tools.ietf.org/html/rfc8288#section-3.3
      REGEXP_REG_REL_TYPE_PATTERN = '[a-z\d][a-z\d\-\.]*'.freeze

      # Liberal pattern matching a string of text between angle brackets
      # https://tools.ietf.org/html/rfc5988#section-5.1
      REGEXP_TARGET_URI_PATTERN = /^<(.*)>;/

      # Ultra-orthodox pattern matching Link header `rel` parameter including a `micropub` value
      # https://www.w3.org/TR/micropub/#endpoint-discovery
      REGEXP_MICROPUB_REL_PATTERN = /(?:;|\s)rel="?(?:#{REGEXP_REG_REL_TYPE_PATTERN}+\s)?micropub(?:\s#{REGEXP_REG_REL_TYPE_PATTERN})?"?/

      attr_reader :uri, :url

      def initialize(url)
        raise ArgumentError, "url must be a String (given #{url.class.name})" unless url.is_a?(String)

        @url = url
        @uri = Addressable::URI.parse(url)
      rescue Addressable::URI::InvalidURIError => error
        raise InvalidURIError, error
      end

      def endpoint
        @endpoint ||= absolutize(base: url, relative: (endpoint_from_headers || endpoint_from_body)) || nil
      end

      def response
        @response ||= HTTP.follow.headers(HTTP_HEADERS_OPTS).timeout(
          connect: 10,
          read: 10
        ).get(uri)
      rescue HTTP::ConnectionError => error
        raise ConnectionError, error
      rescue HTTP::TimeoutError => error
        raise TimeoutError, error
      rescue HTTP::Redirector::TooManyRedirectsError => error
        raise TooManyRedirectsError, error
      end

      private

      def absolutize(base:, relative:)
        return unless relative

        base_uri = Addressable::URI.parse(base)
        relative_uri = Addressable::URI.parse(relative)

        return relative if relative_uri.absolute?

        (base_uri + relative_uri).to_s
      rescue Addressable::URI::InvalidURIError => error
        raise InvalidURIError, error
      end

      def endpoint_from_body
        return unless response.mime_type == 'text/html'

        doc = Nokogiri::HTML(response.body.to_s)

        # Search response body for first `link` element with valid `rel` attribute
        link_element = doc.css('link[rel~="micropub"][href]').shift

        return link_element['href'] if link_element
      end

      def endpoint_from_headers
        link_headers = response.headers.get('link')

        return unless link_headers

        # Split Link headers with multiple values, flatten the resulting array, and strip whitespace
        link_headers = link_headers.map { |header| header.split(',') }.flatten.map(&:strip)

        micropub_header = link_headers.find { |header| header.match?(REGEXP_MICROPUB_REL_PATTERN) }

        return unless micropub_header

        endpoint_match_data = micropub_header.match(REGEXP_TARGET_URI_PATTERN)

        return endpoint_match_data[1] if endpoint_match_data
      end
    end
  end
end
