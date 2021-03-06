module Micropub
  module Endpoint
    class Response
      HTTP_HEADERS_OPTS = {
        accept: '*/*',
        user_agent: 'Micropub Endpoint Discovery (https://rubygems.org/gems/micropub-endpoint)'
      }.freeze

      def initialize(uri)
        raise ArgumentError, "uri must be an Addressable::URI (given #{uri.class.name})" unless uri.is_a?(Addressable::URI)

        @uri = uri
      end

      def response
        @response ||= HTTP.follow.headers(HTTP_HEADERS_OPTS).timeout(
          connect: 10,
          read: 10
        ).get(@uri)
      rescue HTTP::ConnectionError => error
        raise ConnectionError, error
      rescue HTTP::TimeoutError => error
        raise TimeoutError, error
      rescue HTTP::Redirector::TooManyRedirectsError => error
        raise TooManyRedirectsError, error
      end
    end
  end
end
