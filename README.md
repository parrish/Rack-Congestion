# Rack::Congestion

Rack middleware for [Congestion](https://github.com/parrish/Congestion)

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

### In a Rack application

```ruby
require 'rack/congestion'

Congestion.default_options[:interval] = 60
Congestion.default_options[:max_in_interval] = 100 # allow 100 requests / minute
Congestion.default_options[:min_delay] = 0.1       # allow 1 request / 100 ms

use Rack::Congestion::IpLimiter

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
