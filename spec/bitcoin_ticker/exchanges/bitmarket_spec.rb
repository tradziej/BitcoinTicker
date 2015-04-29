require 'spec_helper'
require 'bitcoin_ticker/exchanges/bitmarket'
require 'shared_examples_for_ticker'

describe BitcoinTicker::Bitmarket do
  subject { described_class }

  it { is_expected.to respond_to(:ticker).with(2).arguments }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:link) }

  describe "#name" do
    it "returns exchange name" do
      expect(subject.name).to eq("BitMarket")
    end
  end

  describe "#link" do
    it "returns exchange link" do
      expect(subject.link).to eq("https://www.bitmarket.pl/")
    end
  end

  describe "private #ticker_endpoint" do
    let(:currency) { :pln }
    let(:bitcurrency) { :btc }

    it "returns exchange endpoint to the ticker" do
      subject.instance_variable_set("@currency", currency)
      subject.instance_variable_set("@bitcurrency", bitcurrency)

      expect(subject.send(:ticker_endpoint)).to eq("/json/#{bitcurrency.upcase}#{currency.upcase}/ticker.json")
    end
  end

  describe "#ticker" do
    include_examples "common for #ticker method", :btc, :pln

    it "returns correct Bitcoin rates" do
      stub_request(:get, 'https://www.bitmarket.pl/json/BTCPLN/ticker.json')
        .to_return(
          body: fixture('bitmarket_btc_pln.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:btc, :pln)

      expect(exchange.ask).to eq(835.8998)
      expect(exchange.bid).to eq(830.0001)
      expect(exchange.last).to eq(832)
      expect(exchange.low).to eq(825.0003)
      expect(exchange.high).to eq(868)
      expect(exchange.vwap).to eq(840.4816)
      expect(exchange.volume).to eq(500.8205)
    end

    it "returns correct Litecoin rates" do
      stub_request(:get, 'https://www.bitmarket.pl/json/LTCPLN/ticker.json')
        .to_return(
          body: fixture('bitmarket_ltc_pln.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:ltc, :pln)

      expect(exchange.ask).to eq(5.4334)
      expect(exchange.bid).to eq(4.8501)
      expect(exchange.last).to eq(4.8494)
      expect(exchange.low).to eq(4.8493)
      expect(exchange.high).to eq(5.4349)
      expect(exchange.vwap).to eq(5.1251)
      expect(exchange.volume).to eq(95.2013)
    end
  end
end
