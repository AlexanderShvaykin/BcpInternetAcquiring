module BcpInternetAcquiring
  class BCP
    attr_reader :params

    class << self
      attr_accessor :current_bcp
    end

    def register_order(order_number:, sum:)
      BCP.current_bcp = self
      Order.build(order_number: order_number,
                  sum: sum,
                  days: expiration_days,
                  return_url: return_url,
                  auth_data: auth_data)
        .register
    end

    def status_order(id)
      Order.new(auth_data).status(id)
    end

    private

    # you need add config:
    # config.base_url
    # config.return_url
    # config.password
    # config.user_name
    def initialize(name, params)
      @params = OpenStruct.new(params)
      @name   = name
    end

    def return_url
      params.return_url
    end

    def expiration_days
      @expiration_days ||= params.expiration_days || 5
    end

    def auth_data
      {
        userName: params.user_name,
        password: params.password
      }
    end
  end
end