# TODO: переименовать классы ошибок
module BcpInternetAcquiring
  class BcpBankApiError < StandardError; end
  class BadResponseFormat < BcpBankApiError
    def initialize(msg = 'Server response not JSON')
      super(msg)
    end
  end

  class CreateOrderError < BcpBankApiError; end
  class OrderValidationError < BcpBankApiError; end
  class StatusOrderError < BcpBankApiError
    attr_reader :code, :status

    def initialize(msg, code: nil, status: nil)
      @code = code
      @status = status
      super(msg)
    end
  end
end