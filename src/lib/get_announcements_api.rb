# frozen_string_literal: true

# nethttp2.rb
require 'uri'
require 'net/http'
require 'dotenv/load'
require 'dotenv'
require 'json'
require 'nokogiri'
require_relative 'get_course_api'

# View Canvas announcements for a specific course.
# @author Jared Malto, Sam Reichman, Andy Clemens
class GetAnnouncementsApi < GetCourseApi
  # endpoint constant
  ANNOUNCEMENTS = '/announcements'

  # Gets a course's announcements.
  # @param active_only true if user wants only active assignments, false otherwise
  # @return JSON response body of course announcements
  def announcements(active_only)
    # context code format: courses_[course_id]
    context_code = "courses_#{@course_id}"
    url = "#{@base_url}#{ANNOUNCEMENTS}?context_codes[]=#{context_code}&active_only=#{active_only}"
    response = call_get url
    # parse raw response body
    JSON.parse response.body
  end

  # Sorts given announcements
  # @param announcements JSON parsed announcements
  # @return [announcements with publish date in ascending order]
  def sort_announcements_by_release_date_ascending_order(announcements)
    announcements.sort_by { |announcement| DateTime.strptime(announcement['posted_at']).to_time.localtime }
  end

  # Outputs JSON announcements. checks if list is empty and prints accordingly.
  # @param announcements parsed JSON announcements
  # @return nil
  def print_announcements(announcements)
    # check for empty list
    if announcements.empty?
      puts "No announcements to display for course #{@course_id}."
      return
    end
    # if not, we can output each announcement with relevant data
    announcements.each do |announcement|
      # sometimes raw HTML tags will appear in messages
      # this call to nokogiri will remove them
      message_text = Nokogiri::HTML.fragment(announcement['message']).text.strip
      puts "Title: #{announcement['title']}"
      puts "Posted on: #{announcement['posted_at']}"
      puts "Message: #{message_text}\n\n"
    end
  end
end

# get_announcements_api = GetAnnouncementsApi.new('150754')
# announcements = get_announcements_api.announcements(true)
# get_announcements_api.print_announcements announcements
