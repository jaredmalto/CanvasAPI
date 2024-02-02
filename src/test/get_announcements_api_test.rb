# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/get_announcements_api'

# Class to test the getAnnouncements class
# @author Sam Reichman
class GetAnnouncementsApiTest < Test::Unit::TestCase
  def setup
    @get_announcements_api = GetAnnouncementsApi.new
  end

  # Test the announcements method with a valid course id
  def test_announcements_not_active
    # Arrange
    active_only = false
    # Act
    actual = @get_announcements_api.announcements active_only
    # Assert
    assert_not_nil actual

  end

  # Test the announcements method with an invalid course id
  def test_announcements_active
    # Arrange
    active_only = true
    # Act
    actual = @get_announcements_api.announcements active_only
    # Assert
    assert_empty actual
  end

  def test_sort_announcements_by_release_date
    announcement1 = { 'posted_at' => '2023-10-15' }
    announcement2 = { 'posted_at' => '2023-10-14' }
    announcement3 = { 'posted_at' => '2023-10-16' }
    announcements = [announcement1, announcement2, announcement3]
    api = GetAnnouncementsApi.new
    actual_announcements = api.sort_announcements_by_release_date announcements
    expected_announcements = [announcement2, announcement1, announcement3]
    raise 'Unexpected result' unless expected_announcements == actual_announcements
  end

  # Test the print_announcements method
  def test_print_announcements
    # Arrange
    announcements = [
      {
        'title' => 'Announcement 1',
        'posted_at' => '2020-01-01',
        'message' => '<p>Message 1</p>'
      }
    ]

    # Act
    actual = @get_announcements_api.print_announcements announcements

    # Assert
    assert_not_nil actual
  end
end
