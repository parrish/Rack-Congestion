module Rack
  module Congestion
    class Limiter
      attr_accessor :app, :options
      attr_reader :env

      def initialize(app, options = { })
        self.app = app
        self.options = options
      end

      def call(env)
        @env = env
        request.allowed? ? app.call(env) : rejected_response
      end

      def request
        @request ||= Rack::Congestion::Request.new env, key, options
      end

      def key
        ->{ 'global' }
      end

      def rejected_response
        [
          429,
          {
            'Content-Type' => 'text/plain; charset=utf-8',
            'Retry-After' => backoff
          },
          ['Rate Limit Exceeded']
        ]
      end

      def backoff
        request.backoff.to_s rescue -1
      end
    end
  end
end
