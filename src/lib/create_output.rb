# frozen_string_literal: false

# require relative library files and date gem
require 'date'
require_relative 'get_base_api'
require_relative 'get_course_api'
require_relative 'get_assignments_api'
require_relative 'get_announcements_api'

# CreateOutput class to create output.html file with user to-do list and announcements available through Carmen Canvas
# Authors: Andy Clemens and Mikkel Baterina
class CreateOutput
  attr_accessor :template_path

  TEMPLATE_PATH = 'src/lib/outputTemplate.html'.freeze
  OUTPUT_PATH = 'src/lib/output.html'.freeze
  COURSES_URL = 'https://osu.instructure.com/courses/'.freeze

  # Replaces substring in the HTML template with student specific information
  # @param file the HTML template file
  # @param replacements the hash of substrings and their values to be replaced with
  # @return the new string with the substring replaced
  def replace_template(file, replacements)
    text = File.read file
    replacements.each do |key, value|
      text = text.gsub(key, value)
    end
    text
  end

  # Creates the HTML output substring for the to-do list
  # @param assignments the list of assignments
  # @return the HTML output substring for user's assignments
  def create_assignment_table(assignments)
    # Create a string of HTML table rows
    text = ''
    assignments.each do |assignment|
      # Convert the due date to a more readable format
      due_date = assignment['due_at']
      due_date = DateTime.strptime(due_date).to_time.localtime.strftime('%a %b %1e %l:%M %p') unless due_date.nil?
      due_date = 'No due date' if assignment['due_at'].nil?
      # Add the table row to the text
      text << "\t\t<tr>\n\t\t\t<td><a href='#{COURSES_URL}#{assignment['course_id']}' target='_blank'>
      \t\t\t#{assignment['course_name']}</a></td>\n\t\t\t<td><a href='#{assignment['html_url']}' target='_blank'>
      \t\t\t#{assignment['name']}</a></td>\n\t\t\t<td>#{due_date}</td>\n\t\t</tr>\n"
    end
    # Return the text with the surrounding whitespace removed
    text.strip
  end

  # Creates the HTML output substring for the announcements
  # @param announcements the list of announcements
  # @return the HTML output substring for user's announcements
  def create_announcement_table(announcements)
    # Create a string of HTML table rows
    text = ''
    announcements.each do |announcement|
      # Convert the announcement date to a more readable format
      posted_date = DateTime.strptime(announcement['posted_at']).to_time.localtime.strftime('%a %b %1e')
      # Add the table row to the string
      text << "\t\t<tr>\n\t\t\t<td>#{announcement['user_name']}</td>
      \t\t<td><a href='#{announcement['html_url']}' target='_blank'>#{announcement['title']}</a></td>
      \t\t<td>#{posted_date}</td>\n\t\t\t<td>#{announcement['message']}</td>\n\t\t</tr>\n"
    end
    # Return the string with the surrounding whitespace removed
    text.strip
  end

  # Gets all assignments for the user's current courses
  # @param courses the list of courses
  # @return the list of assignments, sorted by due date
  def get_all_assignments(courses)
    # Get all assignments for each course
    assignments = []
    assignment_api = GetAssignmentsApi.new
    courses.each do |course|
      assignments.concat(assignment_api.current_assignments(course[1]).each do |assignment|
                           assignment['course_name'] = course[0]
                         end)
    end
    assignment_api.sort_assignments_by_due_date_ascending assignments
  end

  # Gets all announcements for the user's current courses
  # @param courses the list of courses
  # @return the list of announcements, sorted by posted date
  def get_all_announcements(courses)
    # Get all announcements for each course
    announcements = []
    courses.each { |course| announcements.concat(GetAnnouncementsApi.new(course[1]).announcements(true)) }
    GetAnnouncementsApi.new.sort_announcements_by_release_date_ascending_order announcements
  end

  # Writes the output to the file, HTML format
  # @param file the file to write to
  # @param output the output to write to the file
  def write_to_file(file, output)
    # Write the output to the file
    File.open(file, 'w') { |f| f.puts output }
  end

  # Creates the output.html file, generated in path src/lib/output.html
  # @return nil
  def create_output
    # Get all current classes
    courses = GetCourseApi.new.current_classes
    # Get all assignments for each course and sort them by due date
    assignments = get_all_assignments courses
    # Get all announcements for each course and sort them by posted date
    announcements = get_all_announcements courses
    # Create the table of assignments
    assignment_table = create_assignment_table assignments
    # Create the table of announcements
    announcement_table = create_announcement_table announcements

    # Create a hash of replacement strings and their values to be replaced with
    replacements = { '<!-- TODO LIST -->' => assignment_table, '<!-- ANNOUNCEMENT LIST -->' => announcement_table }
    text = replace_template(TEMPLATE_PATH, replacements)
    # Write the output to the file
    write_to_file(OUTPUT_PATH, text)
  end
end
