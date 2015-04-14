# Rack::Congestion

[![Build Status](https://travis-ci.org/parrish/Rack-Congestion.svg?branch=master)](https://travis-ci.org/parrish/Rack-Congestion)
[![Test Coverage](https://codeclimate.com/github/parrish/Rack-Congestion/badges/coverage.svg)](https://codeclimate.com/github/parrish/Rack-Congestion)
[![Code Climate](https://codeclimate.com/github/parrish/Rack-Congestion/badges/gpa.svg)](https://codeclimate.com/github/parrish/Rack-Congestion)

Rack middleware for [Congestion](https://github.com/parrish/Congestion)

Provides rate limiting for Rack-based applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-congestion'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-congestion

## Usage

The available limiters are:

- `Rack::Congestion::Limiter`
  - Application-wide limiting
- `Rack::Congestion::IpLimiter`
  - Limits requests per-IP
- `Rack::Congestion::PathLimiter`
  - Limits requests for a path segment
  - e.g. limit requests to `'/api'`
  - accepts `path:`(required) and `path_matcher:`(optional) options

Examples and more advanced usage can be found in [examples](examples)

[Documentation of Congestion configuration can be found here](https://github.com/parrish/Congestion#user-content-configuration)

### In a Rack application

```ruby
require 'rack/congestion'

# Limit requests to
#   - a maximum of 100 requests per minute
#   - a maximum rate of 1 request every 100 milliseconds
use Rack::Congestion::IpLimiter, interval: 60, max_in_interval: 100, min_delay: 0.1

run ->(env){
  [200, { 'Content-Type' => 'text/plain' }, ['Hello world']]
}
```

### In a Rails application

```ruby
# config/application.rb
require 'rack/congestion'

class YourApplication < Rails::Application
  config.middleware.use Rack::Congestion::IpLimiter
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To run the specs, run `bundle exec rake`.

## Contributing

1. Fork it ( https://github.com/parrish/rack-congestion/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
