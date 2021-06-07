# frozen_string_literal: true

require_relative "ipgeobase/version"
require_relative 'ipgeobase/ip_model'
require 'nokogiri-happymapper'
require "net/http"

module Ipgeobase
  class Error < StandardError; end

  def self.lookup(ip)
    uri = URI("http://ip-api.com/xml/#{ip}")
    response = Net::HTTP.get_response(uri)

    IpModel.parse(response.body)
  end
end
