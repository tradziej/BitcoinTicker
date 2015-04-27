require 'spec_helper'
require 'bitcoin_ticker/exchanges/bitmaszyna'
require 'shared_examples_for_ticker'

describe BitcoinTicker::Bitmaszyna do
  subject { described_class }

  it { is_expected.to respond_to(:ticker).with(2).arguments }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:link) }

  describe "#name" do
    it "returns exchange name" do
      expect(subject.name).to eq("bitmaszyna.pl")
    end
  end

  describe "#link" do
    it "returns exchange link" do
      expect(subject.link).to eq("https://bitmaszyna.pl/")
    end
  end

  describe "private #ticker_endpoint" do
    let(:currency) { :pln }
    let(:bitcurrency) { :btc }

    it "returns exchange endpoint to the ticker" do
      subject.instance_variable_set("@currency", currency)
      subject.instance_variable_set("@bitcurrency", bitcurrency)

      expect(subject.send(:ticker_endpoint)).to eq("/api/#{bitcurrency.upcase}#{currency.upcase}/ticker.json")
    end
  end

  describe "#ticker" do
    include_examples "common for #ticker method"

    it "returns correct Bitcoin rates" do
      stub_request(:get, 'https://bitmaszyna.pl/api/BTCPLN/ticker.json')
        .to_return(
          body: fixture('bitmaszyna_btc_pln.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:btc, :pln)

      expect(exchange.ask).to eq(840.0000)
      expect(exchange.bid).to eq(828.5200)
      expect(exchange.last).to eq(829.7000)
      expect(exchange.low).to eq(822.6600)
      expect(exchange.high).to eq(860.0000)
      expect(exchange.vwap).to eq(836.0433)
      expect(exchange.volume).to eq(0.6986)
    end

    it "returns correct Litecoin rates" do
      stub_request(:get, 'https://bitmaszyna.pl/api/LTCPLN/ticker.json')
        .to_return(
          body: fixture('bitmaszyna_ltc_pln.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:ltc, :pln)

      expect(exchange.ask).to eq(5.1100)
      expect(exchange.bid).to eq(5.0500)
      expect(exchange.last).to eq(5.1100)
      expect(exchange.low).to eq(5.1100)
      expect(exchange.high).to eq(5.1100)
      expect(exchange.vwap).to eq(5.1100)
      expect(exchange.volume).to eq(3.0763)
    end
  end
end
