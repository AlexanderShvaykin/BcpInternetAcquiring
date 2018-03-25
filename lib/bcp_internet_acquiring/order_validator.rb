module BcpInternetAcquiring
  class OrderValidator
    attr_reader :verifiable

    def check(order)
      @verifiable = order
      check_number
      check_sum
      check_url
      order
    end

    private

    def check_number
      number = verifiable.order_number
      raise OrderValidationError, 'Order number can not be empty' if number.empty?
    end

    def check_sum
      sum = verifiable.sum
      raise OrderValidationError, 'Sum can only be positive numeric' unless sum.positive?
    end

    def check_url
      url = verifiable.return_url
      uri = URI.parse url
      raise OrderValidationError, 'Bad return_url' unless uri.scheme && uri.host
    end
  end
end