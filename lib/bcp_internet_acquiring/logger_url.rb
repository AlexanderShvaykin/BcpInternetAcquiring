module BcpInternetAcquiring
  class LoggerUrl
    class << self
      def logging_request(method, url, params, logger)
        filtered_url = filtered_url_log(url, 'password', 'userName')
        logger.info("#{method.to_s.upcase}: #{filtered_url} | whith params: #{params}")
      end

      private

      def filtered_url_log(url, *keys)
        params = BaseAPI.url_to_params(url)
        return url unless params
        filter = {}
        keys.each { |key| filter[key] = '#filtered' }
        url.split('?')[0] + "?#{URI.encode_www_form(params.merge(filter))}"
      end
    end
  end
end