require 'rack/congestion'

# Limit requests to
#   - a global maximum of 10 requests per minute
#   - a maximum of 1 request per minute per user
use Rack::Congestion::Limiter,   interval: 60, max_in_interval: 10
use Rack::Congestion::IpLimiter, interval: 60, max_in_interval: 1

run ->(env){
  [200, { 'Content-Type' => 'text/plain' }, ['Hello world']]
}
