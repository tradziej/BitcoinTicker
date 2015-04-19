require 'spec_helper'
require 'bitcoin_ticker/client'

describe BitcoinTicker::Client do
  let(:api_endpoint) { "https://www.bitmarket.pl" }
  let(:path) { "/json/BTCPLN/ticker.json" }
  let(:endpoint) { api_endpoint }
  subject(:client) { described_class.new(endpoint) }

  context "without endpoint" do
    it { expect { described_class.new }.to raise_error }
  end

  describe "#get" do
    context "when response is 200" do
      it "returns OpenStruct with http code and body hash" do
        stub_get = stub_request(:get, api_endpoint + path).
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => "", :headers => {})

        response = client.get(path)

        expect(response).to respond_to(:code)
        expect(response.code).to eq('200')
        expect(response).to respond_to(:body)
        expect(response.body).to be_empty
      end
    end

    context "when response is in 400..499 range" do
      it "fails with error message" do
        stub_get = stub_request(:get, api_endpoint + path).
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 401, :body => "", :headers => {})

        expect { client.get(path) }.to raise_error('client error')
      end
    end

    context "when response is in 500..599 range" do
      it "fails with error message" do
        stub_get = stub_request(:get, api_endpoint + path).
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 500, :body => "", :headers => {})

        expect { client.get(path) }.to raise_error('server error')
      end
    end
  end


end
