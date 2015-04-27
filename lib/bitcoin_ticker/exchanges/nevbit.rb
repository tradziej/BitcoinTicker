module BitcoinTicker
  class Nevbit
    extend Exchange

    SUPPORTED_BITCURRENCIES = %i(btc ltc)
    SUPPORTED_CURRENCIES = %i(pln)

    def self.name
      "nevbit"
    end

    def self.link
      "https://nevbit.com/"
    end

    def self.ticker_endpoint
      "/data/#{@bitcurrency}#{@currency}/ticker.json"
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
        volume: hash[:vol],
        bid: hash[:buy],
        ask: hash[:sell]
      }
    end
    private_class_method :normalize_api_response
  end
end
