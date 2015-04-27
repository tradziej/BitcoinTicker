require 'spec_helper'
require 'bitcoin_ticker/exchanges/bitbay'
require 'shared_examples_for_ticker'

describe BitcoinTicker::Bitbay do
  subject { described_class }

  it { is_expected.to respond_to(:ticker).with(2).arguments }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:link) }

  describe "#name" do
    it "returns exchange name" do
      expect(subject.name).to eq("BitBay")
    end
  end

  describe "#link" do
    it "returns exchange link" do
      expect(subject.link).to eq("https://bitbay.net/")
    end
  end

  describe "private #ticker_endpoint" do
    let(:currency) { :pln }
    let(:bitcurrency) { :btc }

    it "returns exchange endpoint to the ticker" do
      subject.instance_variable_set("@currency", currency)
      subject.instance_variable_set("@bitcurrency", bitcurrency)

      expect(subject.send(:ticker_endpoint)).to eq("/API/Public/#{bitcurrency}#{currency}/ticker.json")
    end
  end

  describe "#ticker" do
    include_examples "common for #ticker method"

    it "returns correct Bitcoin rates" do
      stub_request(:get, 'https://bitbay.net/API/Public/btcpln/ticker.json')
        .to_return(
          body: fixture('bitbay_btc_pln.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:btc, :pln)

      expect(exchange.ask).to eq(834.9900)
      expect(exchange.bid).to eq(824.0100)
      expect(exchange.last).to eq(834.9900)
      expect(exchange.low).to eq(818.0000)
      expect(exchange.high).to eq(845.9900)
      expect(exchange.vwap).to eq(829.9800)
      expect(exchange.volume).to eq(632.6999)
    end

    it "returns correct Litecoin rates" do
      stub_request(:get, 'https://bitbay.net/API/Public/ltcpln/ticker.json')
        .to_return(
          body: fixture('bitbay_ltc_pln.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
        )

      exchange = subject.ticker(:ltc, :pln)

      expect(exchange.ask).to eq(6.9700)
      expect(exchange.bid).to eq(4.9200)
      expect(exchange.last).to eq(4.9400)
      expect(exchange.low).to eq(4.9400)
      expect(exchange.high).to eq(5.0000)
      expect(exchange.vwap).to eq(5.6800)
      expect(exchange.volume).to eq(10.0000)
    end
  end
end
