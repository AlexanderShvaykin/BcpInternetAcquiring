module BcpInternetAcquiring
  class Order < BaseAPI
    attr_accessor :order_number, :days, :sum, :return_url, :expiration_days, :order_id, :form_url,
                  :status_code

    def self.build(auth_data:, order_number:, days:, sum:, return_url:, validator: OrderValidator.new)
      order = new(auth_data)

      order.expiration_days = DateTime.now.next_day(days.to_i).strftime(DATE_FORMAT)
      order.order_number    = order_number.to_s
      order.sum             = sum.to_f
      order.return_url      = return_url
      validator.check(order)
    end

    def register
      response =
        http_client.get(path: query_string(CREATE_ORDER_PATH, orderNumber:    order_number,
                                           amount:         kopecks(sum),
                                           returnUrl:      return_url,
                                           expirationDate: expiration_days))
      raise CreateOrderError, response['errorMessage'] if response['errorCode']

      @order_id = data(response, 'orderId')
      @form_url = data(response, 'formUrl')
      self
    end

    def status(id = order_id)
      return unless id
      response = http_client.get(path: query_string(GET_ORDER_STATUS_PATH, orderId: id))
      unless response['ErrorCode'].to_i.zero?
        raise StatusOrderError.new(response['ErrorMessage'], code: response['ErrorCode'],
                                   status: response['OrderStatus'])
      end

      @status_code = data(response, 'OrderStatus')
    end

    private

    def kopecks(rubles)
      (rubles * 100).to_i
    end

    def data(response, key)
      response.fetch(key)
    rescue KeyError
      raise BadResponseFormat, "server not return #{key}"
    end
  end
end