require 'spec_helper'
require 'bitcoin_ticker/exchanges/bitcurex'
require 'shared_examples_for_ticker'

describe BitcoinTicker::Bitcurex do
  subject { described_class }

  it { is_expected.to respond_to(:ticker).with(2).arguments }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:link) }

  describe "#name" do
    it "returns exchange name" do
      expect(subject.name).to eq("Bitcurex")
    end
  end

  describe "#link" do
    it "returns exchange link" do
      expect(subject.link).to eq("https://bitcurex.com/")
    end
  end

  describe "private #ticker_endpoint" do
    let(:currency) { :usd }
    let(:bitcurrency) { :btc }

    it "returns exchange endpoint to the ticker" do
      subject.instance_variable_set("@currency", currency)
      subject.instance_variable_set("@bitcurrency", bitcurrency)

      expect(subject.send(:ticker_endpoint)).to eq("/api/#{currency}/ticker.json")
    end
  end

  describe "#ticker" do
    include_examples "common for #ticker method"

    it "returns correct Bitcoin rates" do
      stub_request(:get, 'https://bitcurex.com/api/usd/ticker.json')
        .to_return(
          body: fixture('bitcurex_btc_usd.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:btc, :usd)

      expect(exchange.ask).to eq(221.8740)
      expect(exchange.bid).to eq(221.7787)
      expect(exchange.last).to eq(221.8740)
      expect(exchange.low).to eq(220.0904)
      expect(exchange.high).to eq(224.5051)
      expect(exchange.vwap).to eq(nil)
      expect(exchange.volume).to eq(70.0576)
    end
  end
end
