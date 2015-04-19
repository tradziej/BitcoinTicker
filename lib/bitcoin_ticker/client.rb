require 'net/http'
require 'openssl'
require 'uri'
require 'ostruct'
require 'json'

module BitcoinTicker
  class Client
    def initialize(endpoint)
      @uri = URI.parse(endpoint)

      http
    end

    def get(path)
      response = request(path)

      case response.code.to_i
      when 200, 201
        body = response.body ? JSON.parse(response.body, symbolize_names: true) : ""
        OpenStruct.new(code: response.code, body: body)
      when (400..499)
        fail 'client error'
      when (500..599)
        fail 'server error'
      end
    rescue JSON::ParserError
      response
    end

   private
    def http
      @http ||= begin
        http = Net::HTTP.new(@uri.host, @uri.port)
        http.use_ssl = @uri.scheme == 'https'
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http
      end
    end

    def request(path)
      request = Net::HTTP::Get.new(path)

      @http.request(request)
    end
  end
end
