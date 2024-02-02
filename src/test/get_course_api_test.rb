# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/get_course_api'

# Class to test the getCourse class
# @author Sam Reichman
class GetCourseApiTest < Test::Unit::TestCase
  def setup
    @get_course_api = GetCourseApi.new
  end

  # Test the current_classes method
  def test_current_classes
    # Arrange
    # Act
    actual = @get_course_api.current_classes
    # Assert
    assert_not_nil actual
    assert_not_empty actual
  end

  # Test the extract_classes method for valid input
  def test_extract_classes_valid
    # Arrange
    parsed_classes = [{ 'name' => 'Class 1', 'id' => '12345' }]
    expected = { 'Class 1' => '12345' }
    # Act
    @get_course_api.extract_classes parsed_classes
    # Assert
    assert_equal(expected, @get_course_api.instance_variable_get(:@courses))
  end

  # Test the extract_classes method for invalid input
  def test_extract_classes_invalid
    # Arrange
    parsed_classes = [{ 'name' => 'Class 1' }]
    expected = { 'Class 1' => nil }
    # Act
    @get_course_api.extract_classes parsed_classes
    # Assert
    assert_equal(expected, @get_course_api.instance_variable_get(:@courses))
  end

  # Test the print_courses method
  def test_print_courses
    # Arrange
    # Act
    actual = @get_course_api.print_courses

    # Assert
    assert_not_nil actual
  end
end
