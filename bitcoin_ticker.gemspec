# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitcoin_ticker/version'

Gem::Specification.new do |spec|
  spec.name          = "bitcoin_ticker"
  spec.version       = BitcoinTicker::VERSION
  spec.authors       = ["Tomasz Radziejewski"]
  spec.email         = ["tomasz@radziejewski.pl"]

  spec.description   = %q{Wrapper for cryptocurrency (e.g. Bitcoin, Litecoin) price tickers.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/tradziej/BitcoinTicker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
