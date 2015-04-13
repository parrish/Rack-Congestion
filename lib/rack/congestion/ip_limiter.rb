module Rack
  module Congestion
    class IpLimiter < Limiter
      def key
        ->{ request ? request.ip : nil }
      end
    end
  end
end
