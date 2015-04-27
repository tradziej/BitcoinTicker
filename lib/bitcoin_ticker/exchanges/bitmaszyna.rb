module BitcoinTicker
  class Bitmaszyna
    extend Exchange

    SUPPORTED_BITCURRENCIES = %i(btc ltc)
    SUPPORTED_CURRENCIES = %i(pln)

    def self.name
      "bitmaszyna.pl"
    end

    def self.link
      "https://bitmaszyna.pl/"
    end

    def self.ticker_endpoint
      "/api/#{@bitcurrency.upcase}#{@currency.upcase}/ticker.json"
    end
    private_class_method :ticker_endpoint

    def self.get_rate
      client = BitcoinTicker::Client.new(link)

      response = client.get(ticker_endpoint)

      BitcoinTicker::Rate.new(@bitcurrency, @currency, normalize_api_response(response[:body]))
    end
    private_class_method :get_rate

    def self.normalize_api_response hash
      {
        last: hash[:last],
        high: hash[:high],
        low: hash[:low],
        vwap: hash[:vwap],
        volume: hash[:volume1],
        bid: hash[:bid],
        ask: hash[:ask]
      }
    end
    private_class_method :normalize_api_response
  end
end
