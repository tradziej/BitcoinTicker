require 'spec_helper'
require 'bitcoin_ticker/rate'

describe BitcoinTicker::Rate do
  subject { BitcoinTicker::Rate.new(:btc, :pln, rate_hash) }
  let(:rate_hash) {
    {
      high: 20,
      last: 10,
      low: 5,
      vwap: 3,
      ask: 50,
      bid: 6,
    }
  }

  it { is_expected.to respond_to(:bitcurrency) }
  it { is_expected.to respond_to(:currency) }
  it { is_expected.to respond_to(:last) }
  it { is_expected.to respond_to(:high) }
  it { is_expected.to respond_to(:low) }
  it { is_expected.to respond_to(:vwap) }
  it { is_expected.to respond_to(:volume) }
  it { is_expected.to respond_to(:bid) }
  it { is_expected.to respond_to(:ask) }

  it "sets arrguments depending of passed rate hash" do
    rate_hash.each do |key, value|
      expect(subject.send(key)).to eq(value)
    end
  end

  describe "private #normalize_value" do
    context "when value is a string or number" do
      it "returns float rounded off to four decimal places" do
        [5.1239876, "5.1239876"].each do |value|
          expect(subject.send(:normalize_value, value)).to eq(5.1240)
        end
      end
    end

    context "when value is not a string or number" do
      it "returns a nil" do
        [nil, []].each do |value|
          expect(subject.send(:normalize_value, value)).to eq(nil)
        end
      end
    end
  end
end
