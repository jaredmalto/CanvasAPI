# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/create_output'

# Class to test the createOutput class
# @authors Sam Reichman and Andy Clemens
class CreateOutputTest < Test::Unit::TestCase
  def setup
    @create_output = CreateOutput.new
  end

  # Test the replace_template method
  def test_replace_template
    # Arrange
    file = 'src/test/testOutputTemplate.html'
    replacements = { 'To-Do' => 'Test 1', '<!-- ANNOUNCEMENTS -->' => 'Test 2' }
    expected = '<h1>Carmen Test 1 List</h1>
Test 2
'
    # Act
    actual = @create_output.replace_template(file, replacements)
    # Assert
    assert_not_nil actual
    assert_equal(expected, actual)
  end

  # Test the create_assignment_table method
  def test_create_assignment_table
    # Arrange
    assignments = [
      {
        'name' => 'Assignment 1', 'course_id' => '1', 'course_name' => 'Course 1', 'html_url' => 'url1'
      }, {
        'name' => '2', 'due_at' => '2023-10-09T14:20:00Z', 'course_id' => '2', 'course_name' => 'Course 2', 'html_url' => 'url2'
      }
    ]
    expected = "<tr>
			<td><a href='https://osu.instructure.com/courses/1' target='_blank'>
      			Course 1</a></td>
			<td><a href='url1' target='_blank'>
      			Assignment 1</a></td>
			<td>No due date</td>
		</tr>
		<tr>
			<td><a href='https://osu.instructure.com/courses/2' target='_blank'>
      			Course 2</a></td>
			<td><a href='url2' target='_blank'>
      			2</a></td>
			<td>Mon Oct 9 10:20 AM</td>
		</tr>"
    # Act
    actual = @create_output.create_assignment_table assignments
    # Assert
    assert_not_nil actual
    assert_equal(expected, actual)
  end

  # Test the create_announcement_table method
  def test_create_announcement_table
    # Arrange
    announcements = [
      {
        'user_name' => 'User 1', 'title' => 'Announcement 1', 'posted_at' => '2023-10-09T02:47:29Z', 'message' => 'Message 1', 'html_url' => 'url1'
      }, {
        'user_name' => 'User 2', 'title' => 'Announcement 2', 'posted_at' => '2023-10-09T14:20:00Z', 'message' => 'Message 2', 'html_url' => 'url2'
      }
    ]
    expected = "<tr>
			<td>User 1</td>
      		<td><a href='url1' target='_blank'>Announcement 1</a></td>
      		<td>Sun Oct 8</td>
			<td>Message 1</td>
		</tr>
		<tr>
			<td>User 2</td>
      		<td><a href='url2' target='_blank'>Announcement 2</a></td>
      		<td>Mon Oct 9</td>
			<td>Message 2</td>
		</tr>"
    # Act
    actual = @create_output.create_announcement_table announcements
    # Assert
    assert_not_nil actual
    assert_equal(expected, actual)
  end

  # Test the get_all_assignments method
  def test_get_all_assignments
    # Arrange
    # Act
    actual = @create_output.get_all_assignments GetCourseApi.new.current_classes
    # Assert
    assert_not_nil actual
    assert_not_empty actual
  end

  # Test the get_all_announcements method
  def test_get_all_announcements
    # Arrange
    # Act
    actual = @create_output.get_all_announcements GetCourseApi.new.current_classes
    # Assert
    assert_not_nil actual
    assert_not_empty actual
  end

  # Test the write_to_file method
  def test_write_to_file
    # Arrange
    file = 'src/test/testWriting.html'
    output = 'Test'
    # Act
    @create_output.write_to_file file, output
    # Assert
    assert File.exist?(file)
    assert_equal("#{output}\n", File.read(file))
  end

  # Test the create_output method
  def test_create_output
    # Arrange
    # Act
    @create_output.create_output
    # Assert
    assert File.exist?('src/lib/output.html')
  end
end
