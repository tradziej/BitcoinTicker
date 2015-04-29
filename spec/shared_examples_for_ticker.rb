shared_examples "common for #ticker method" do |bitcurrency, currency|
  it "receives #ensure_supported_bitcurrency" do
    allow(subject).to receive(:get_rate) { nil }
    expect(subject).to receive(:ensure_supported_bitcurrency).once
    subject.ticker(bitcurrency, currency)
  end

  it "receives #ensure_supported_currency" do
    allow(subject).to receive(:get_rate) { nil }
    expect(subject).to receive(:ensure_supported_currency).once
    subject.ticker(bitcurrency, currency)
  end

  context "when incorrect arrguments" do
    context "and bitcurrency is incorrect" do
      it "returns BitcoinTicker::UnsupportedBitcurrency error with message" do
        unsapported_bitcurrency = :fake_bitcurrency
        expect { subject.ticker(unsapported_bitcurrency, currency) }.to(
          raise_error(BitcoinTicker::UnsupportedBitcurrency,
            "#{unsapported_bitcurrency} is not supported")
        )
      end
    end

    context "and currency is incorrect" do
      it "returns BitcoinTicker::UnsupportedCurrency error" do
        unsapported_currency = :fake_currency
        expect { subject.ticker(bitcurrency, unsapported_currency) }.to(
          raise_error(BitcoinTicker::UnsupportedCurrency,
            "#{unsapported_currency} is not supported")
          )
      end
    end
  end

  context "when correct arrguments" do
    it "returns Rate object" do
      allow_any_instance_of(BitcoinTicker::Client).to receive(:get).and_return({code: 200, body: {}})
      subject.stub(:normalize_api_response) { {} }
      expect(subject.ticker(bitcurrency, currency)).to be_kind_of(BitcoinTicker::Rate)
    end
  end
end
