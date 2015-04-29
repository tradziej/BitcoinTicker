require 'spec_helper'
require 'bitcoin_ticker/exchanges/nevbit'
require 'shared_examples_for_ticker'

describe BitcoinTicker::Nevbit do
  subject { described_class }

  it { is_expected.to respond_to(:ticker).with(2).arguments }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:link) }

  describe "#name" do
    it "returns exchange name" do
      expect(subject.name).to eq("nevbit")
    end
  end

  describe "#link" do
    it "returns exchange link" do
      expect(subject.link).to eq("https://nevbit.com/")
    end
  end

  describe "private #ticker_endpoint" do
    let(:currency) { :pln }
    let(:bitcurrency) { :btc }

    it "returns exchange endpoint to the ticker" do
      subject.instance_variable_set("@currency", currency)
      subject.instance_variable_set("@bitcurrency", bitcurrency)

      expect(subject.send(:ticker_endpoint)).to eq("/data/#{bitcurrency}#{currency}/ticker.json")
    end
  end

  describe "#ticker" do
    include_examples "common for #ticker method", :btc, :pln

    it "returns correct Bitcoin rates" do
      stub_request(:get, 'https://nevbit.com/data/btcpln/ticker.json')
        .to_return(
          body: fixture('nevbit_btc_pln.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:btc, :pln)

      expect(exchange.ask).to eq(850.0000)
      expect(exchange.bid).to eq(817.0000)
      expect(exchange.last).to eq(818.6500)
      expect(exchange.low).to eq(817.0000)
      expect(exchange.high).to eq(850.9000)
      expect(exchange.vwap).to eq(836.9261)
      expect(exchange.volume).to eq(2.5335)
    end

    it "returns correct Litecoin rates" do
      stub_request(:get, 'https://nevbit.com/data/ltcpln/ticker.json')
        .to_return(
          body: fixture('nevbit_ltc_pln.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:ltc, :pln)

      expect(exchange.ask).to eq(14.0000)
      expect(exchange.bid).to eq(5.0000)
      expect(exchange.last).to eq(5.0000)
      expect(exchange.low).to eq(5.0000)
      expect(exchange.high).to eq(5.0000)
      expect(exchange.vwap).to eq(5.0000)
      expect(exchange.volume).to eq(0.0100)
    end
  end
end
