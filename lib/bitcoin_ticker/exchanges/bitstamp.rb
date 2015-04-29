module BitcoinTicker
  class Bitstamp
    extend Exchange

    SUPPORTED_BITCURRENCIES = %i(btc)
    SUPPORTED_CURRENCIES = %i(usd)

    def self.name
      "Bitstamp"
    end

    def self.link
      "https://www.bitstamp.net/"
    end

    def self.ticker_endpoint
      "/api/ticker/"
    end
    private_class_method :ticker_endpoint
  end
end
