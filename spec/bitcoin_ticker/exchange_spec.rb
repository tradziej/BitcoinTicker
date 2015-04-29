require 'spec_helper'
require 'bitcoin_ticker/exchange'
require 'shared_examples_for_ticker'

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

  describe "ticker" do
    include_examples "common for #ticker method", :btc, :pln
  end
end
