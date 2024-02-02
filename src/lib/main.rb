# frozen_string_literal: true

# Main file to interact with user through terminal interations (?), handles user input
# Path: src/lib/main.rb
# requires .env file to be in root directory, contains user value for CANVAS_TOKEN

# don't need user interaction, acts as a single access point for an html doc output

require_relative 'create_output'

# main method to execute program
# Author: Mikkel Baterina
def main
  # message to user about the output of the program
  puts 'Hello! We are getting your todo list from Canvas along with any announcements.'
  # create instance of CreateOutput class
  output = CreateOutput.new
  # call create_output method, cascading method calls of other files
  output.create_output if $PROGRAM_NAME == __FILE__
  # message to user about the output of the program
  puts 'Done! Check the output.html file in the lib folder (path: src/lib/output.html).'
end

main
