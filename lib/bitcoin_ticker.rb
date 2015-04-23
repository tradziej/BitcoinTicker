require "bitcoin_ticker/version"
require "bitcoin_ticker/client"
require "bitcoin_ticker/errors"
require "bitcoin_ticker/rate"
require "bitcoin_ticker/exchange"
Gem.find_files("bitcoin_ticker/exchanges/*.rb").each { |path| require path }
