module BitcoinTicker
  class Bitmarket24
    extend Exchange

    SUPPORTED_BITCURRENCIES = %i(btc ltc)
    SUPPORTED_CURRENCIES = %i(pln)

    def self.name
      "BitMarket24"
    end

    def self.link
      "https://www.bitmarket24.pl/"
    end

    def self.ticker_endpoint
      "/api/#{@bitcurrency.upcase}_#{@currency.upcase}/status.json"
    end
    private_class_method :ticker_endpoint
  end
end
