# BitcoinTicker

[![Build Status](https://travis-ci.org/tradziej/BitcoinTicker.svg)](https://travis-ci.org/tradziej/BitcoinTicker)

Wrapper for cryptocurrency (e.g. Bitcoin, Litecoin) price tickers.

Currently gem support following exchanges:
* BitBay (https://bitbay.net/)

  | ticker                                                | bitcurrency | currency      |
  |-------------------------------------------------------|-------------|---------------|
  | BitcoinTicker::Bitbay.ticker(:bitcurrency, :currency) | BTC, LTC    | PLN, USD, EUR |

* Bitcurex (https://bitcurex.com/)

  | ticker                                                  | bitcurrency | currency      |
  |---------------------------------------------------------|-------------|---------------|
  | BitcoinTicker::Bitcurex.ticker(:bitcurrency, :currency) | BTC, LTC    | PLN, USD, EUR |

* BitMarket (https://www.bitmarket.pl/)

  | ticker                                                   | bitcurrency | currency |
  |----------------------------------------------------------|-------------|----------|
  | BitcoinTicker::Bitmarket.ticker(:bitcurrency, :currency) | BTC, LTC    | PLN      |

* BitMarket24 (https://www.bitmarket24.pl/)

  | ticker                                                     | bitcurrency | currency |
  |------------------------------------------------------------|-------------|----------|
  | BitcoinTicker::Bitmarket24.ticker(:bitcurrency, :currency) | BTC, LTC    | PLN      |

* bitmaszyna.pl (https://bitmaszyna.pl/)

  | ticker                                                    | bitcurrency | currency |
  |-----------------------------------------------------------|-------------|----------|
  | BitcoinTicker::Bitmaszyna.ticker(:bitcurrency, :currency) | BTC, LTC    | PLN      |

* Bitstamp (https://www.bitstamp.net/)

  | ticker                                                  | bitcurrency | currency |
  |---------------------------------------------------------|-------------|----------|
  | BitcoinTicker::Bitstamp.ticker(:bitcurrency, :currency) | BTC         | USD      |

* BTC-e (https://btc-e.com/)

  | ticker                                              | bitcurrency | currency      |
  |-----------------------------------------------------|-------------|---------------|
  | BitcoinTicker::Btce.ticker(:bitcurrency, :currency) | BTC, LTC    | USD, EUR, GBP |

* nevbit (https://nevbit.com/)

  | ticker                                                | bitcurrency | currency      |
  |-------------------------------------------------------|-------------|---------------|
  | BitcoinTicker::Nevbit.ticker(:bitcurrency, :currency) | BTC, LTC    | USD, EUR, GBP |

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bitcoin_ticker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitcoin_ticker

## Usage

Fetch prices from the each exchange, e.g.

    exchange = BitcoinTicker::Bitstamp.ticker(:btc, :usd)
    #<BitcoinTicker::Rate:0x007fe10215c558
     @ask=226.48,
     @bid=226.3,
     @bitcurrency=:btc,
     @currency=:usd,
     @high=226.99,
     @last=226.5,
     @low=221.81,
     @timestamp=1430340454.0,
     @volume=8873.2263,
     @vwap=224.73>

Get rate attributes:

    puts exchange.bitcurrency
    puts exchange.currency
    puts exchange.last
    puts exchange.high
    puts exchange.low
    puts exchange.vwap
    puts exchange.volume
    puts exchange.bid
    puts exchange.ask

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/bitcoin_ticker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
