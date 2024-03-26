require "test_helper"

class VodacomTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Vodacom::VERSION
  end

  def test_that_the_client_has_compatible_api_version
    assert_equal 'v4', Vodacom::Client.compatible_api_version
  end

  def test_that_the_client_has_api_version
    assert_equal 'v4 2024-03-26', Vodacom::Client.api_version
  end
end
