module BitcoinTicker
  class Rate
    attr_reader :bitcurrency, :currency, :last, :high, :low, :vwap, :volume, :bid, :ask

    def initialize(bitcurrency, currency, rate_hash)
      @bitcurrency = bitcurrency
      @currency = currency

      rate_hash.each do |key, value|
        instance_variable_set("@#{key}", normalize_value(value))
      end

      self
    end

   private
    def normalize_value(value)
      case value
      when String, Numeric
        sprintf('%.4f', value).to_f
      else
        nil
      end
    end
  end
end
