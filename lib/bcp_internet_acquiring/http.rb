module BcpInternetAcquiring
  class HTTP
    attr_reader :logger, :base_url

    def get(options)
      request(options)
    end

    private

    def initialize
      @logger   = BcpInternetAcquiring::BCP.current_bcp.params.logger || Logger.new('log/bank.log')
      @base_url = BcpInternetAcquiring::BCP.current_bcp.params.base_url
      raise ArgumentError, 'I dont know base url!' unless @base_url
    end

    def request(path:, payload: '')
      method = caller(1..1).first[/`.*'/][1..-2].to_sym
      response = RestClient::Request.execute(method: method, url: url(path), payload: payload)
      LoggerUrl.logging_request(method, url(path), payload, logger)

      parse_response(response)
    rescue RestClient::ExceptionWithResponse => e
      return parse_response(e.response)
    end

    def content_type(rest_error)
      rest_error.http_headers.content_type
    end

    def parse_response(response)
      logger.info("Response: #{response.body}")
      JSON.parse(response.body)
    rescue JSON::ParserError
      raise BcpInternetAcquiring::BadResponseFormat
    end

    def url(path)
      base_url + path
    end
  end
end