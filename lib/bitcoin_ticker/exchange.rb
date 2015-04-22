module BitcoinTicker
  module Exchange
    def ticker(bitcurrency, currency)
      ensure_supported_bitcurrency(bitcurrency)
      ensure_supported_currency(currency)

      @bitcurrency = bitcurrency
      @currency = currency

      get_rate
    end

   private
    def get_rate
      client = BitcoinTicker::Client.new(link)

      response = client.get(ticker_endpoint)

      BitcoinTicker::Rate.new(@bitcurrency, @currency, response[:body])
    end

    def ensure_supported_bitcurrency(bitcurrency)
      unless self::SUPPORTED_BITCURRENCIES.include?(bitcurrency)
        fail BitcoinTicker::UnsupportedBitcurrency, "#{bitcurrency} is not supported"
      end
    end

    def ensure_supported_currency(currency)
      unless self::SUPPORTED_CURRENCIES.include?(currency)
        fail BitcoinTicker::UnsupportedCurrency, "#{currency} is not supported"
      end
    end
  end
end
