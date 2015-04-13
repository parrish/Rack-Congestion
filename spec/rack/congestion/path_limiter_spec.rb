require 'spec_helper'

describe Rack::Congestion::PathLimiter do
  include_context 'app helpers'
  it_behaves_like 'a limiter' do
    let(:limiter_options){ { path: 'foo/bar' } }
    let(:limiter){ path_limited_app }
    let(:env){ Rack::MockRequest.env_for 'foo/bar' }

    before(:each) do
      allow(mocked_request).to receive(:path).and_return '/foo/bar'
    end

    it 'should set the key to the path' do
      limiter.call env
      expect(limiter.key.call).to eql '/foo/bar'
    end

    context '#ignore?' do
      it 'should not ignore matching paths' do
        allow(limiter.request).to receive(:path).and_return '/foo/bar/baz'
        expect(limiter).to_not be_ignored
      end

      it 'should ignore other paths' do
        allow(limiter.request).to receive(:path).and_return '/bar/foo'
        expect(limiter).to be_ignored
      end
    end
  end
end
