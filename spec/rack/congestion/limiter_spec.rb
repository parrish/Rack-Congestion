require 'spec_helper'

describe Rack::Congestion::Limiter do
  include_context 'app helpers'
  it_behaves_like 'a limiter' do
    let(:limiter){ limited_app }

    it 'should set the key to global' do
      expect(limiter.key.call).to eql 'global'
    end
  end
end
