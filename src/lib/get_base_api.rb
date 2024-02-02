# frozen_string_literal: true

# nethttp2.rb
require 'uri'
require 'net/http'
require 'dotenv/load'
require 'dotenv'
require 'json'

# GetBaseApi class to make GET requests to the Canvas API
class GetBaseApi
  # Initialize the class, load the .env file, and set the canvas token
  def initialize(course_id = nil)
    # Specify the path to the .env file
    dotenv_path = '../../.env'
    # Load the environment variables from the specified file
    Dotenv.load(dotenv_path)
    @canvas_token = ENV['CANVAS_TOKEN']
    @base_url = 'https://osu.instructure.com/api/v1'
    @current_time = Time.now
    @courses = {}
    @course_id = course_id
  end

  # Make a GET request to the specified URL
  # @param url [String] the URL to make the GET request to
  def call_get(url, body = nil)
    uri = URI.parse(url)
    uri.query = URI.encode_www_form(body) unless body.nil?
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{@canvas_token}"
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
    error_check(response)
    response
  end

  # Check the response code and print the response body
  # @param response [Net::HTTPResponse] the response from the GET request
  # @return [Integer] the response code
  def error_check(response)
    code = response.code.to_i
    if code != 200
      # Handle errors or other status codes
      puts "HTTP Error: #{response.code}"
    end
    # puts "Response: #{response.body}"
    code
  end
end
