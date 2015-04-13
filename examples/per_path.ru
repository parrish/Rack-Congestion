require 'rack/congestion'

# Limit requests to
#   - a maximum of 10 requests per minute to /api
#   - a maximum of 5 requests per minute to everything else
use Rack::Congestion::PathLimiter, path: 'api', interval: 60,
  max_in_interval: 10

use Rack::Congestion::PathLimiter, path: 'other', interval: 60,
  max_in_interval: 5, path_matcher: /^\/(?!api)/i

run ->(env){
  [200, { 'Content-Type' => 'text/plain' }, ['Hello world']]
}
