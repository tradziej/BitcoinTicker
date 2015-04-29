module BitcoinTicker
  class Btce
    extend Exchange

    SUPPORTED_BITCURRENCIES = %i(btc ltc)
    SUPPORTED_CURRENCIES = %i(usd eur gbp)

    def self.name
      "BTC-e"
    end

    def self.link
      "https://btc-e.com/"
    end

    def self.ticker_endpoint
      "/api/3/ticker/#{@bitcurrency}_#{@currency}"
    end
    private_class_method :ticker_endpoint

    def self.get_rate
      client = BitcoinTicker::Client.new(link)

      response = client.get(ticker_endpoint)

      BitcoinTicker::Rate.new(@bitcurrency, @currency, normalize_api_response(response[:body]))
    end
    private_class_method :get_rate

    def self.normalize_api_response hash
      pair_name_sym = "#{@bitcurrency}_#{@currency}".to_sym

      {
        last: hash[pair_name_sym][:last],
        high: hash[pair_name_sym][:high],
        low: hash[pair_name_sym][:low],
        vwap: nil,
        volume: hash[pair_name_sym][:vol],
        bid: hash[pair_name_sym][:buy],
        ask: hash[pair_name_sym][:sell]
      }
    end
    private_class_method :normalize_api_response
  end
end
