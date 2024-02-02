# frozen_string_literal: true

# nethttp2.rb
require 'uri'
require 'net/http'
require 'dotenv/load'
require 'dotenv'
require 'json'
require 'date'
require_relative 'get_base_api'

# View assignments for a specific course.
# @author Jared Malto, Sam Reichman, Andy Clemens
class GetAssignmentsApi < GetBaseApi
  # endpoint constant
  ASSIGNMENTS = '/assignments'

  # Gets a user's current assignments
  # @param course_id 4-5 digit course id
  # @return [assignments currently not past due]
  def current_assignments(course_id)
    url = "#{@base_url}/courses/#{course_id}#{ASSIGNMENTS}"
    response = call_get url
    # parse the response
    assignments = JSON.parse response.body
    # this block checks each assignment and adds
    # the assignment to the list if its due date has not yet passed
    assignments.select do |assignment|
      due_date = !assignment['due_at'].nil? ? DateTime.strptime(assignment['due_at']).to_time : @current_time
      due_date > @current_time
    end
  end

  # Gets all assignments for a course
  # @param course_id 4-5 digit course id
  # @return [all published assignments in a course]
  def all_assignments(course_id)
    url = "#{@base_url}/courses/#{course_id}/assignments"
    response = call_get url
    # parse the response
    JSON.parse(response.body)
  end

  # Sorts given assignments
  #  @param assignments
  #  @return [assignments with due date in ascending order]
  def sort_assignments_by_due_date_ascending(assignments)
    assignments.sort_by { |assignment| DateTime.strptime(assignment['due_at']).to_time.localtime }
  end

  # Prints a list of the assignments in a list
  # @param assignments parsed JSON assignments
  # @return nil
  def print_assignments(assignments)
    assignments.each do |assignment|
      name = assignment['name']
      due_date = assignment['due_at']
      points = assignment['points_possible']
      puts "Name: #{name}"
      puts "Due: #{due_date}"
      puts "Points: #{points}"
      puts "\n"
    end
  end
end
