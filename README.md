# Project

## Description

This project requires an active and valid Canvas API token. The program generates a TO-DO list from the user's Canvas account along with the active and most recent announcements from the user's current classes, presented in earliest to latest.

## Required Gems

The required gems for this project are dotenv, json, and nokogiri. To install these, run the following in the top level directory:
```
  bundle install
```

## Generating and Using Canvas API Token
In order to access the API's endpoints, a user must generate an API token. To do this, log in and navigate to a canvas dashboard. Click on account >> settings and scroll down to a section titled "Approved Integrations". At the bottom, click New access token and fill out a purpose and expiration date, then hit "Generate Token". Save this somewhere safe and treat it like a password.

Once you have an access token. navigate to the root directory of the project's .gitignore. Add the following line.

```
  CANVAS_TOKEN = <YOUR_ACCESS_TOKEN>
```

This allows the project to pull the user's courses and related data.

## API calls

The backend allows a user to get their assignments, announcements, and courses using the Canvas LMS API. 

### Assignments
When given a course id (4 or 5 digit section number), a user can retreive their current and past assignments for their class. They can then see the name, due date, and the possible amount of points they can achieve.

### Announcements
When given a course id, the api will then convert it to an acceptable context code. The user can then choose whether or not to display only active or inactive announcements as well. The data displayed consists of the title, the day the announcement was posted on, and the message with any embedded links.

### Courses
This displays all active classes a user is taking with a valid Canvas API token. This displays the name and id of the course.

## Meeting 1 9/28/23

- Mikkel to lead project
- Preliminary Ideas include:
  - Create a list of people the user shares a class with
  - Make a to-do list with the assignments the user has due in the classes currently enrolled in
- Plan to get API key from Canvas, review API, and come with more in-depth ideas for next meeting
- Next meeting: 10/1/23

## Meeting 2 10/1/23

- Main focus for project will be to create a to-do list with the assignments the user has due in the classes currently enrolled in
- Jared: list assignments (<https://canvas.instructure.com/doc/api/assignments.html#method.assignments_api.index>)
- Andy list courses (<https://canvas.instructure.com/doc/api/courses.html#method.courses.students>)
- Sam modular code for api.rb
- Mikkel parsing of calls
- Next meeting: 10/3/23 8:00 PM

## Meeting 3 10/3/23

- Agenda:
  - Review progress
    - What work has been done so far in terms of GET requests, what information do we have fully parsed
  - Discuss next steps
    - What do we want to do with this information
    - What else do we think is possible to do with our current state
    - How do we want to display it (Command window, web page, another open api (Todoist?))

- Meeting Notes:
  - Progress:
    - GET request for courses and assignments done, the work is a little sloppy currently but it is functional
  - Next Steps:
    - Project lists to-do list items for a specific time frame, features to pick out specific courses
    - Search for a name and see if you're in a class with them
    - Get announcements (most recent)
    - If we only do to-do list capabilities, we can make it more robust outside of terminal (html page, Todoist)
  - Work delegated
    - Andy: front end (html page with all features)
    - Mikkel: help with css file, clean up current work
    - Jared: GET request for announcements, decide what announcements to display
    - Sam: Split classes (different gets, printing classes), utility knife (troubleshooting backup), clean up request parameters (not query string)
  - Next meeting: 10/5/23 8:00 PM (EDIT: meeting moved to 10/6/23, 4:45 PM)

## Meeting 4 10/6/23

- Agenda:
  - Review Progress, project is due before class monday
    - Where are we at with the requests for announcements, what announcements are we grabbing
    - Modularity: do we want a main to interact with user in the terminal
      - If so, what do we want the user to be able to do with the program, what are we outputting
    - Where are we at with HTML generation?? How do we want to structure the page
      - CSS goes with how far along we are with HTML doc
  - Discuss next steps
    - How in depth do we want to go with HTML page (just display information?)
    - Give user control over how long in the future to display assignments? How do we go about that

- Meeting Notes:
  - GET requests look goo for both assignments and announcements
  - What needs to still get done:
    - HTML page
      - solve errors about missing a due_at element for some assignments
    - CSS
      - Need to know how HTML looks before starting
    - Main
      - No user interactment, just a main to consolidate all the work to generate a front end page with announcements and assignments
    - Test cases
  - In good shape to meet the deadline, barring any project breaking errors
  - work delegation
    - Andy: HTML page
    - Mikkel: CSS, start main
    - Sam: Test cases for api calls
    - Jared: Help Andy with HTML errors (specifically due at tags for assignments)
  - Next meeting: Sunday, 10/8/23, 2:00 PM

## Meeting 5 10/8/23, FINAL MEETING

- Agenda:
  - Review Progress
    - HTML is generated, CSS needs to be done
    - Documentation? Testing?
    - Main is implemented, maybe look a little better if we want it to
  - Discuss next steps
    - Testing
    - CSS
    - Documentation

- Meeting Notes:

