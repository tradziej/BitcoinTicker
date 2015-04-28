module BitcoinTicker
  class Bitcurex
    extend Exchange

    SUPPORTED_BITCURRENCIES = %i(btc)
    SUPPORTED_CURRENCIES = %i(pln eur usd)

    def self.name
      "Bitcurex"
    end

    def self.link
      "https://bitcurex.com/"
    end

    def self.ticker_endpoint
      "/api/#{@currency}/ticker.json"
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
        last: hash[:last_tx_price_h],
        high: hash[:highest_tx_price_h],
        low: hash[:lowest_tx_price_h],
        vwap: nil,
        volume: hash[:total_volume_h],
        bid: hash[:best_bid_h],
        ask: hash[:best_ask_h]
      }
    end
    private_class_method :normalize_api_response
  end
end
