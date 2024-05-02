## Overview:

This is a command-line application written in Ruby that generates tweet-like reviews for movies based on employee reviews. The application parses JSON files containing movie and review data, composes tweet-like reviews, and outputs them to the terminal. It follows the Model-View-Controller (MVC) architecture to ensure separation of concerns and maintainability.

## Usage: 

To run the application, execute the main.rb file:

ruby main.rb


## Components:
Model

    movie_review: Represents a movie review, including the reviewer's comments, rating, movie title and year.

View

    tweet_view: Responsible for formatting and displaying output in the terminal.

Controller

    movie_review_controller: Parses the JSON files containing review and movie data and creates movie_review object. It also composes tweet-like reviews based on given conditions using movie_review object.

Data

    movies.json: JSON file containing movie data.
    reviews.json: JSON file containing review data.

Tests

  The tests directory contains test cases for controller component of the application. Tests are written using Rspec.

  To run the tests, 

  1. navigate to tests directory
  2. exec:
      rspec movie_review_controller_spec.rb


## Example Output:

Star Wars (1977): Great, this film was ★★★★
Star Wars The Force Awake (2015): A long time ago in a galaxy far far away someone made the best sci-fi film of all time. Then some chap ★★½

## Additional information

To run this application you need to have these libraries installed:

json: To parse json files
Rspec: To run testcases
Faker: To run testcases with fake data

   

