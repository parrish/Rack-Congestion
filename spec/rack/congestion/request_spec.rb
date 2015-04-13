require 'spec_helper'

describe Rack::Congestion::Request do
  let(:mock_env){ Hash.new }
  let(:mock_options){ Hash.new }
  let(:mock_key){ Proc.new{ 'foo' } }
  let(:request){ Rack::Congestion::Request.new mock_env, mock_key, mock_options }
  subject{ request }

  describe '#rack_request' do
    it 'should initialize a Rack::Request' do
      expect(Rack::Request).to receive(:new).with mock_env
      request.rack_request
    end
  end

  describe '#congestion' do
    it 'should initialize a Congestion request' do
      expect(Congestion).to receive(:request).with mock_key, mock_options
      request.congestion
    end

    it 'should resolve the key' do
      expect(mock_key).to receive :call
      request.congestion
    end
  end

  it{ is_expected.to delegate :ip,           to: :rack_request }
  it{ is_expected.to delegate :path,         to: :rack_request }
  it{ is_expected.to delegate :cookies,      to: :rack_request }
  it{ is_expected.to delegate :content_type, to: :rack_request }
  it{ is_expected.to delegate :session,      to: :rack_request }
  it{ is_expected.to delegate :scheme,       to: :rack_request }
  it{ is_expected.to delegate :ssl?,         to: :rack_request }
  it{ is_expected.to delegate :delete?,      to: :rack_request }
  it{ is_expected.to delegate :get?,         to: :rack_request }
  it{ is_expected.to delegate :head?,        to: :rack_request }
  it{ is_expected.to delegate :options?,     to: :rack_request }
  it{ is_expected.to delegate :link?,        to: :rack_request }
  it{ is_expected.to delegate :patch?,       to: :rack_request }
  it{ is_expected.to delegate :post?,        to: :rack_request }
  it{ is_expected.to delegate :put?,         to: :rack_request }
  it{ is_expected.to delegate :trace?,       to: :rack_request }
  it{ is_expected.to delegate :unlink?,      to: :rack_request }
  it{ is_expected.to delegate :xhr?,         to: :rack_request }

  it{ is_expected.to delegate :allowed?,       to: :congestion }
  it{ is_expected.to delegate :backoff,        to: :congestion }
  it{ is_expected.to delegate :first_request,  to: :congestion }
  it{ is_expected.to delegate :last_request,   to: :congestion }
  it{ is_expected.to delegate :rejected?,      to: :congestion }
  it{ is_expected.to delegate :too_frequent?,  to: :congestion }
  it{ is_expected.to delegate :too_many?,      to: :congestion }
  it{ is_expected.to delegate :total_requests, to: :congestion }
end
