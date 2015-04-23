module BitcoinTicker
  class Bitmarket
    extend Exchange

    SUPPORTED_BITCURRENCIES = %i(btc ltc)
    SUPPORTED_CURRENCIES = %i(pln)

    def self.name
      "BitMarket"
    end

    def self.link
      "https://www.bitmarket.pl/"
    end

    def self.ticker_endpoint
      "/json/#{@bitcurrency.upcase}#{@currency.upcase}/ticker.json"
    end
    private_class_method :ticker_endpoint
  end
end
