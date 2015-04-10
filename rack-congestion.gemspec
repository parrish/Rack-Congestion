# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/congestion/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack-congestion'
  spec.version       = Rack::Congestion::VERSION
  spec.authors       = ['Michael Parrish']
  spec.email         = ['michael@zooniverse.org']

  spec.summary       = %q{Redis rate limiter Rack middleware}
  spec.description   = %q{Rack middleware rate limiter that provides both time-based limits and quantity-based limits}
  spec.homepage      = 'https://github.com/parrish/rack-congestion'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency     'congestion', '~> 0.0.2'
  spec.add_runtime_dependency     'rack', '>= 1.5'
  spec.add_development_dependency 'bundler', '>= 1.5'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rspec-its', '~> 1.2'
  spec.add_development_dependency 'guard-rspec', '~> 4.5'
  spec.add_development_dependency 'timecop', '~> 0.7'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
