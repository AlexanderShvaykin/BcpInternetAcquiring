require 'rest-client'
require 'ostruct'
require 'logger'
require 'json'
require 'bcp_internet_acquiring/version'
require 'bcp_internet_acquiring/exceptions'
require 'bcp_internet_acquiring/logger_url'
require 'bcp_internet_acquiring/http'
require 'bcp_internet_acquiring/base_api'
require 'bcp_internet_acquiring/order_validator'
require 'bcp_internet_acquiring/order'
require 'bcp_internet_acquiring/bcp'

module BcpInternetAcquiring
  CREATE_ORDER_PATH     = '/register.do'.freeze
  GET_ORDER_STATUS_PATH = '/getOrderStatus.do'.freeze
  GET_ORDER_EXTENDED_STATUS_PATH = '/getOrderStatusExtended.do'.freeze
  DATE_FORMAT = '%Y-%m-%dT%H:%M:%S'.freeze
end
