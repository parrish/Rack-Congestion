require 'congestion'
require 'rack/congestion/version'

module Rack
  module Congestion
    require 'rack/congestion/request'
    require 'rack/congestion/limiter'
    require 'rack/congestion/ip_limiter'
  end
end
