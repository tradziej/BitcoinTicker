require 'webmock/rspec'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bitcoin_ticker'

WebMock.disable_net_connect!(allow_localhost: true)
