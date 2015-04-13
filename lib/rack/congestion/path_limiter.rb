module Rack
  module Congestion
    class PathLimiter < Limiter
      attr_accessor :path, :path_matcher

      def initialize(app, options = { })
        self.path = normalize_path_from options
        self.path_matcher = normalize_matcher_from options
        super
      end

      def _call(env)
        @env = env
        ignored? ? app.call(env) : super(env)
      end

      def key
        ->{ path }
      end

      def ignored?
        request.path !~ path_matcher
      end

      protected

      def normalize_path_from(options)
        self.path = options.delete :path
        path.sub(/^\/*/, '/').sub /\/+$/, ''
      end

      def normalize_matcher_from(options)
        self.path_matcher = options.delete :path_matcher
        return path_matcher if path_matcher
        Regexp.new path.sub(/^\^?/, '^'), 'i'
      end
    end
  end
end
