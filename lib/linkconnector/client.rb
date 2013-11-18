require 'faraday'

module Linkconnector
  class Client

    attr_accessor :options

    def initialize(options = {})
      raise "Link Connector Requires an API Key" unless options[:api_key].present?
      self.options = options
    end

    def connection
      @conn ||= Faraday.new(:url => endpoint) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end

    def post(url, params)
      connection.get do |request|
        request.url url
        add_common_headers!(request)
        request.params = {Key: options[:api_key]}.merge(params)
      end
    end

    private
      def endpoint
        "http://www.linkconnector.com/"
      end

      def add_common_headers!(request)
        #request.headers["Accept-Encoding"] = "gzip"
        request.headers["Content-Type"] = "application/json"
      end
  end
end