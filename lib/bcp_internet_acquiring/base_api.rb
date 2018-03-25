module BcpInternetAcquiring
  class BaseAPI
    attr_reader :http_client

    def self.url_to_params(url)
      query = URI.parse(url).query
      return unless query
      Hash[URI.decode_www_form(query)]
    end

    def register; end

    def query_string(path, params = {})
      string_params = URI.encode_www_form(params.merge(@auth_data))
      "#{path}?#{string_params}"
    end

    protected

    def initialize(auth_data)
      @http_client = BcpInternetAcquiring::BCP.current_bcp.params.http_client || HTTP.new
      @auth_data = auth_data
    end
  end
end