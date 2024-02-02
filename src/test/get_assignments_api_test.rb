# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/get_assignments_api'

# Class to test the getAssignments class
# @author Sam Reichman
class GetAssignmentsApiTest < Test::Unit::TestCase
  def setup
    @get_assignments_api = GetAssignmentsApi.new
  end

  # Test the current_assignments method with a valid course id
  def test_current_assignments_valid
    # Arrange
    course_id = '148995'
    # Act
    actual = @get_assignments_api.current_assignments course_id
    # Assert
    assert_not_nil actual
    assert_not_empty actual
  end

  # Test the current_assignments method with an invalid course id
  def test_current_assignments_invalid
    # Arrange
    course_id = ''
    # Act
    actual = @get_assignments_api.current_assignments course_id
    # Assert
    assert_empty actual
  end

  def test_sort_assignments_by_due_date
    assignment_1 = {'due_at' => "2023-10-15"}
    assignment_2 = {'due_at' => "2023-12-15"}
    assignment_3 = {'due_at' => "2023-14-15"}
    assignments = [assignment_3, assignment_2, assignment_1]
    actual_assignments = @get_assignments_api.sort_assignments_by_due_date_ascending assignments
    expected_assignments = [assignment_1, assignment_2, assignment_3]

    raise 'Unexpected result' unless expected_assignments == actual_assignments
  end


  # Test the all_assignments method with a valid course id
  def test_all_assignments_valid
    # Arrange
    course_id = '148995'
    # Act
    actual = @get_assignments_api.all_assignments course_id
    # Assert
    assert_not_nil actual
    assert_not_empty actual
  end

  # Test the all_assignments method with an invalid course id
  def test_all_assignments_invalid
    # Arrange
    course_id = ''
    # Act
    actual = @get_assignments_api.all_assignments course_id
    # Assert
    assert_equal('The specified resource does not exist.', actual['errors'][0]['message'])
  end

  # Test the print_assignments method
  def test_print_assignments
    # Arrange
    assignments = [
      {
        'name' => 'Assignment 1',
        'due_at' => '2020-01-01T00:00:00Z',
        'points_possible' => 10
      }
    ]
    # Act
    actual = @get_assignments_api.print_assignments assignments
    # Assert
    assert_equal(assignments, actual)
  end
end
