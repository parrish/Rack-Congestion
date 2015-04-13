require 'rack/congestion'

class CustomLimiter < Rack::Congestion::PathLimiter
  def key
    ->{ "#{ request.ip }-#{ path }" }
  end
end

# Limit requests to
#   - a maximum of 10 requests per minute per user to /api
use CustomLimiter, path: 'api', interval: 60, max_in_interval: 10

run ->(env){
  [200, { 'Content-Type' => 'text/plain' }, ['Hello world']]
}
