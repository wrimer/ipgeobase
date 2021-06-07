require 'happymapper'

module Ipgeobase
  class IpModel
    include HappyMapper

    tag 'query'
    element :city, String, tag: 'city'
    element :country, String, tag: 'country'
    element :countryCode, String, tag: 'countryCode'
    element :lon, Float, tag: 'lon'
    element :lat, Float, tag: 'lat'
  end
end
