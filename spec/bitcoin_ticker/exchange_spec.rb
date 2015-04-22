require 'spec_helper'
require 'bitcoin_ticker/exchange'

describe BitcoinTicker::Exchange do
  class DummyClass
    extend BitcoinTicker::Exchange

    SUPPORTED_BITCURRENCIES = %i(btc ltc)
    SUPPORTED_CURRENCIES = %i(pln)

    def self.link
      "http://dummyclasspage.com"
    end

    def self.ticker_endpoint
      "example/ticker/endpoint"
    end
  end

  subject { DummyClass }

  it { is_expected.to respond_to(:ticker).with(2).arguments }

  describe "#ticker" do
    it "receives #ensure_supported_bitcurrency" do
      allow(subject).to receive(:get_rate) { nil }
      expect(subject).to receive(:ensure_supported_bitcurrency).once
      subject.ticker(:btc, :pln)
    end

    it "receives #ensure_supported_currency" do
      allow(subject).to receive(:get_rate) { nil }
      expect(subject).to receive(:ensure_supported_currency).once
      subject.ticker(:btc, :pln)
    end

    context "when incorrect arrguments" do
      context "and bitcurrency is incorrect" do
        it "returns BitcoinTicker::UnsupportedBitcurrency error with message" do
          unsapported_bitcurrency = :doge
          expect { subject.ticker(unsapported_bitcurrency, :pln) }.to(
            raise_error(BitcoinTicker::UnsupportedBitcurrency,
              "#{unsapported_bitcurrency} is not supported")
          )
        end
      end

      context "and currency is incorrect" do
        it "returns BitcoinTicker::UnsupportedCurrency error" do
          unsapported_currency = :gbp
          expect { subject.ticker(:btc, unsapported_currency) }.to(
            raise_error(BitcoinTicker::UnsupportedCurrency,
              "#{unsapported_currency} is not supported")
            )
        end
      end
    end

    context "when correct arrguments" do
      it "returns Rate object" do
        allow_any_instance_of(BitcoinTicker::Client).to receive(:get).and_return({code: 200, body: {}})
        expect(subject.ticker(:btc, :pln)).to be_kind_of(BitcoinTicker::Rate)
      end
    end
  end
end
