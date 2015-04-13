require 'spec_helper'

RSpec.shared_context 'app helpers' do
  include Rack::Test::Methods
  let(:limiter_options){ { } }

  let(:basic_app) do
    double call: [200, { }, ['Hello world']]
  end

  let(:limited_app) do
    Rack::Congestion::Limiter.new basic_app, limiter_options
  end

  let(:app){ basic_app }
end
