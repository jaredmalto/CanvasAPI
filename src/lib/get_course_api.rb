# frozen_string_literal: true

# nethttp2.rb
require 'uri'
require 'net/http'
require 'dotenv/load'
require 'dotenv'
require 'json'
require_relative 'get_base_api'

# View a user's courses. Requires a valid Canvas API token.
class GetCourseApi < GetBaseApi
  COURSES = '/courses'
  def current_classes
    # Make a GET request to the specified URL for classes that are active and that user is a student

    url = "#{@base_url}#{COURSES}"
    response_body = { enrollment_state: 'active', enrollment_type: 'student' }
    puts url
    response = call_get(url, response_body)
    extract_classes JSON.parse(response.body)
    @courses
  end

  def extract_classes(parsed_classes)
    parsed_classes.each do |course|
      @courses[course['name']] = course['id']
    end
  end

  def print_courses
    @courses.each do |course|
      puts "Course Name: #{course[0]}"
      puts "Course ID: #{course[1]}"
    end
  end
end
