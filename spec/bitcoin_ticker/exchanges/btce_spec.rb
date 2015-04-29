require 'spec_helper'
require 'bitcoin_ticker/exchanges/btce'
require 'shared_examples_for_ticker'

describe BitcoinTicker::Btce do
  subject { described_class }

  it { is_expected.to respond_to(:ticker).with(2).arguments }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:link) }

  describe "#name" do
    it "returns exchange name" do
      expect(subject.name).to eq("BTC-e")
    end
  end

  describe "#link" do
    it "returns exchange link" do
      expect(subject.link).to eq("https://btc-e.com/")
    end
  end

  describe "private #ticker_endpoint" do
    let(:currency) { :usd }
    let(:bitcurrency) { :btc }

    it "returns exchange endpoint to the ticker" do
      subject.instance_variable_set("@currency", currency)
      subject.instance_variable_set("@bitcurrency", bitcurrency)

      expect(subject.send(:ticker_endpoint)).to eq("/api/3/ticker/#{bitcurrency}_#{currency}")
    end
  end

  describe "#ticker" do
    include_examples "common for #ticker method", :btc, :usd

    it "returns correct Bitcoin rates" do
      stub_request(:get, 'https://btc-e.com/api/3/ticker/btc_gbp')
        .to_return(
          body: fixture('btce_btc_gbp.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:btc, :gbp)

      expect(exchange.ask).to eq(149.3)
      expect(exchange.bid).to eq(150.6)
      expect(exchange.last).to eq(150.3)
      expect(exchange.low).to eq(142.1454)
      expect(exchange.high).to eq(155.05)
      expect(exchange.vwap).to eq(nil)
      expect(exchange.volume).to eq(550.1653)
    end

    it "returns correct Litecoin rates" do
      stub_request(:get, 'https://btc-e.com/api/3/ticker/ltc_eur')
        .to_return(
          body: fixture('btce_ltc_eur.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:ltc, :eur)

      expect(exchange.ask).to eq(1.266)
      expect(exchange.bid).to eq(1.284)
      expect(exchange.last).to eq(1.272)
      expect(exchange.low).to eq(1.261)
      expect(exchange.high).to eq(1.334)
      expect(exchange.vwap).to eq(nil)
      expect(exchange.volume).to eq(1602.3568)
    end
  end
end
