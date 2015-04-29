require 'spec_helper'
require 'bitcoin_ticker/exchanges/bitstamp'
require 'shared_examples_for_ticker'

describe BitcoinTicker::Bitstamp do
  subject { described_class }

  it { is_expected.to respond_to(:ticker).with(2).arguments }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:link) }

  describe "#name" do
    it "returns exchange name" do
      expect(subject.name).to eq("Bitstamp")
    end
  end

  describe "#link" do
    it "returns exchange link" do
      expect(subject.link).to eq("https://www.bitstamp.net/")
    end
  end

  describe "private #ticker_endpoint" do
    let(:currency) { :usd }
    let(:bitcurrency) { :btc }

    it "returns exchange endpoint to the ticker" do
      subject.instance_variable_set("@currency", currency)
      subject.instance_variable_set("@bitcurrency", bitcurrency)

      expect(subject.send(:ticker_endpoint)).to eq("/api/ticker/")
    end
  end

  describe "#ticker" do
    include_examples "common for #ticker method", :btc, :usd

    it "returns correct Bitcoin rates" do
      stub_request(:get, 'https://www.bitstamp.net/api/ticker/')
        .to_return(
          body: fixture('bitstamp_btc_usd.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:btc, :usd)

      expect(exchange.ask).to eq(225.6900)
      expect(exchange.bid).to eq(225.5700)
      expect(exchange.last).to eq(225.5400)
      expect(exchange.low).to eq(221.4500)
      expect(exchange.high).to eq(226.3500)
      expect(exchange.vwap).to eq(224.0700)
      expect(exchange.volume).to eq(8852.4517)
    end
  end
end
