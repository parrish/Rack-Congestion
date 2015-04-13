require 'spec_helper'

describe Rack::Congestion::IpLimiter do
  include_context 'app helpers'
  it_behaves_like 'a limiter' do
    let(:limiter){ ip_limited_app }
    let(:env){ Rack::MockRequest.env_for '', 'REMOTE_ADDR' => '123' }

    it 'should set the key to the requesting IP' do
      limiter.call env
      expect(limiter.key.call).to eql '123'
    end
  end
end
