# frozen_string_literal: true

require "test_helper"

class IpgeobaseTest < Minitest::Test
  def setup
    @response_mock = '<?xml version="1.0" encoding="UTF-8"?>
<query>
  <status>success</status>
  <country>Australia</country>
  <countryCode>AU</countryCode>
  <region>QLD</region>
  <regionName>Queensland</regionName>
  <city>South Brisbane</city>
  <zip>4101</zip>
  <lat>-27.4767</lat>
  <lon>153.017</lon>
  <timezone>Australia/Brisbane</timezone>
  <isp>Resource Quality Assurance</isp>
  <org>Resource Quality Assurance</org>
  <as></as>
  <query>1.2.3.4</query>
</query>'
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_return_ip_information
    stub_request(:get, "http://ip-api.com/xml/1.2.3.4").
      with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host' => 'ip-api.com',
          'User-Agent' => 'Ruby'
        }).
      to_return(status: 200, body: @response_mock, headers: {})

    ip_meta = Ipgeobase.lookup("1.2.3.4")

    assert_equal ip_meta.city, "South Brisbane"
    assert_equal ip_meta.country, "Australia"
    assert_equal ip_meta.countryCode, "AU"
    assert_equal ip_meta.lat, -27.4767
    assert_equal ip_meta.lon, 153.017
  end
end
