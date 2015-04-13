require 'rack/congestion'

# Limit requests to
#   - a maximum of 10 requests per minute
#   - a maximum rate of 1 request every second
#   - Unsuccessful requests count towards limits
use Rack::Congestion::Limiter, {
  interval: 60, max_in_interval: 10, min_delay: 1,
  track_rejected: true
}

run ->(env){
  [200, { 'Content-Type' => 'text/plain' }, ['Hello world']]
}
