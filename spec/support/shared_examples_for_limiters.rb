require 'spec_helper'

RSpec.shared_examples_for 'a limiter' do
  include_context 'app helpers'
  subject{ limiter }

  it{ is_expected.to delegate :backoff, to: :request }

  describe '#rejected_response' do
    subject{ limiter.rejected_response }

    its(:first){ is_expected.to eql 429 }
    its(:last){ is_expected.to eql ['Rate Limit Exceeded'] }

    describe 'headers' do
      subject{ limiter.rejected_response[1] }
      its(['Content-Type']){ is_expected.to eql 'text/plain; charset=utf-8' }
      its(['Retry-After']){ is_expected.to be_a Fixnum }
    end
  end

  describe '#call' do
    let(:mocked_request){ double Rack::Congestion::Request }
    let(:mock_request) do
      allow(Rack::Congestion::Request).to receive(:new).and_return mocked_request
      allow(mocked_request).to receive(:allowed?).and_return allowed
    end

    it 'should initialize a request' do
      expect(Rack::Congestion::Request).to receive(:new)
        .with(kind_of(Hash), kind_of(Proc), kind_of(Hash))
        .and_call_original
      limiter.call some: :options
    end

    context 'when a request is allowed' do
      let(:allowed){ true }
      before(:each){ mock_request }

      it 'should ensure the request is allowed' do
        limiter.call Hash.new
        expect(mocked_request).to have_received :allowed?
      end

      it 'should call through to the app' do
        expect(limiter.app).to receive(:call).with Hash.new
        limiter.call Hash.new
      end

      it 'should not reject the response' do
        expect(limiter).to_not receive :rejected_response
        limiter.call Hash.new
      end
    end

    context 'when a request is rejected' do
      let(:allowed){ false }
      before(:each){ mock_request }

      it 'should ensure the request is not allowed' do
        allow(limiter).to receive :rejected_response
        limiter.call Hash.new
        expect(mocked_request).to have_received :allowed?
      end

      it 'should not call through to the app' do
        allow(limiter).to receive :rejected_response
        expect(limiter.app).to_not receive :call
        limiter.call Hash.new
      end

      it 'should reject the response' do
        expect(limiter).to receive :rejected_response
        limiter.call Hash.new
      end
    end
  end
end
