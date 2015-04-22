module BitcoinTicker
  class Error < StandardError; end
  class UnsupportedBitcurrency < Error; end
  class UnsupportedCurrency < Error; end
end
