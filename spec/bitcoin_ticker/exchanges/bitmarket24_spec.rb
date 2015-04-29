require 'spec_helper'
require 'bitcoin_ticker/exchanges/bitmarket24'
require 'shared_examples_for_ticker'

describe BitcoinTicker::Bitmarket24 do
  subject { described_class }

  it { is_expected.to respond_to(:ticker).with(2).arguments }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:link) }

  describe "#name" do
    it "returns exchange name" do
      expect(subject.name).to eq("BitMarket24")
    end
  end

  describe "#link" do
    it "returns exchange link" do
      expect(subject.link).to eq("https://www.bitmarket24.pl/")
    end
  end

  describe "private #ticker_endpoint" do
    let(:currency) { :pln }
    let(:bitcurrency) { :btc }

    it "returns exchange endpoint to the ticker" do
      subject.instance_variable_set("@currency", currency)
      subject.instance_variable_set("@bitcurrency", bitcurrency)

      expect(subject.send(:ticker_endpoint)).to eq("/api/#{bitcurrency.upcase}_#{currency.upcase}/status.json")
    end
  end

  describe "#ticker" do
    include_examples "common for #ticker method", :btc, :pln

    it "returns correct Bitcoin rates" do
      stub_request(:get, 'https://www.bitmarket24.pl/api/BTC_PLN/status.json')
        .to_return(
          body: fixture('bitmarket24_btc_pln.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:btc, :pln)

      expect(exchange.ask).to eq(837.0000)
      expect(exchange.bid).to eq(829.0000)
      expect(exchange.last).to eq(835.0000)
      expect(exchange.low).to eq(825.0000)
      expect(exchange.high).to eq(866.9900)
      expect(exchange.vwap).to eq(839.5452)
      expect(exchange.volume).to eq(125.8237)
    end

    it "returns correct Litecoin rates" do
      stub_request(:get, 'https://www.bitmarket24.pl/api/LTC_PLN/status.json')
        .to_return(
          body: fixture('bitmarket24_ltc_pln.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:ltc, :pln)

      expect(exchange.ask).to eq(7.9500)
      expect(exchange.bid).to eq(5.0000)
      expect(exchange.last).to eq(5.1100)
      expect(exchange.low).to eq(0)
      expect(exchange.high).to eq(0)
      expect(exchange.vwap).to eq(0)
      expect(exchange.volume).to eq(nil)
    end
  end
end
