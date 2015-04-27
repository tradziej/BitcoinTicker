module BitcoinTicker
  class Bitbay
    extend Exchange

    SUPPORTED_BITCURRENCIES = %i(btc ltc)
    SUPPORTED_CURRENCIES = %i(pln usd eur)

    def self.name
      "BitBay"
    end

    def self.link
      "https://bitbay.net/"
    end

    def self.ticker_endpoint
      "/API/Public/#{@bitcurrency}#{@currency}/ticker.json"
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
        high: hash[:max],
        low: hash[:min],
        vwap: hash[:vwap],
        volume: hash[:volume],
        bid: hash[:bid],
        ask: hash[:ask]
      }
    end
    private_class_method :normalize_api_response
  end
end
