require 'forwardable'

module Rack
  module Congestion
    class Request
      extend Forwardable
      attr_accessor :env, :key, :options

      def_delegators :rack_request,
        :ip, :path, :content_type, :session, :scheme,
        :ssl?, :delete?, :get?, :head?, :options?, :link?,
        :patch?, :post?, :put?, :trace?, :unlink?, :cookies, :xhr?

      def_delegators :congestion,
        :allowed?, :backoff, :first_request, :last_request,
        :rejected?, :too_frequent?, :too_many?, :total_requests

      def initialize(env, key, options = { })
        self.env = env
        self.key = key
        self.options = options
      end

      def rack_request
        @rack_request ||= Rack::Request.new env
      end

      def congestion
        @congestion ||= ::Congestion.request key.call, options
      end
    end
  end
end
