# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/get_base_api'

# Class to test the getBaseApi class
# @author Sam Reichman
class GetBaseApiTest < Test::Unit::TestCase
  def setup
    @get_base_api = GetBaseApi.new
  end

  # test to ensure that the call_get method returns a Net::HTTPResponse object
  def test_call_get
    # Arrange
    url = 'https://osu.instructure.com/api/v1/courses'
    # Act
    actual_response = @get_base_api.call_get(url)
    # Assert
    assert_instance_of(Net::HTTPOK, actual_response)
  end

  # test to ensure that the error_check method returns the correct code 200
  def test_error_check_two_hundered
    # Arrange
    api_call_response = @get_base_api.call_get('https://osu.instructure.com/api/v1/courses')
    expected = 200
    # Act
    actual_code = @get_base_api.error_check(api_call_response)
    # Assert
    assert_equal(expected, actual_code)
  end

  # test to ensure that the error_check method returns the correct code 301
  def test_error_check_three_hundered_one
    # Arrange
    api_call_response = @get_base_api.call_get('https://google.com')
    expected = 301
    # Act
    actual_code = @get_base_api.error_check(api_call_response)
    # Assert
    assert_equal(expected, actual_code)
  end

  # test to ensure that the error_check method returns the correct code 404
  def test_error_check_four_hundered_four
    # Arrange
    # call on a non existent page
    api_call_response = @get_base_api.call_get('https://osu.instructure.com/ap')
    expected = 404
    # Act
    actual_code = @get_base_api.error_check(api_call_response)
    # Assert
    assert_equal(expected, actual_code)
  end
end
