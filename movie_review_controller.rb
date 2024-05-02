require 'json'
require 'byebug'
require_relative '../models/movie_review'

class MovieReviewController

  MAX_TWEET_LENGTH = 140
  MAX_TITLE_LENGTH = 25

  def initialize(review_file, movie_file)
    @review_file = review_file
    @movie_file = movie_file
  end

  def read_reviews
    reviews_data = JSON.parse(File.read(@review_file))
    movies = read_movies

    reviews_data.map do |data|
      movie = movies.find { |m| m["title"] == data["title"] }
      MovieReview.new(data["title"], data["review"], data["score"], movie ? movie["year"] : nil)
    end
  end

  def read_movies
    JSON.parse(File.read(@movie_file))
  end

  # Generate tweets based on reviews and movies data
  def generate_tweets
    reviews = read_reviews
    tweets = []

    reviews.each do |review|
      tweet = "#{truncate_tweet(review.review, review.title, review.score, review.year)}"
      tweets << tweet if tweet.length
    end
      tweets
  end

  
  private
  
  #truncate tweet title and reviews to match given conditions
  def truncate_tweet(review, title, score, year)
    year_str = year.nil?? "" : "(#{year})"
    full_tweet = "#{title} #{year_str}: #{review} #{rating_to_star(score)}"
    if full_tweet.length > MAX_TWEET_LENGTH
      new_title = "#{title[0..(MAX_TITLE_LENGTH - 1)]}"
      truncated_tweet = "#{new_title} #{year_str}: #{review} #{rating_to_star(score)}"

      if truncated_tweet.length > MAX_TWEET_LENGTH
        new_review = review
       loop do
          new_review = new_review[0..-2]
          truncated_tweet = "#{new_title} #{year_str}: #{new_review} #{rating_to_star(score)}"
          break if truncated_tweet.length <= MAX_TWEET_LENGTH
        end
          truncated_tweet
      else
        return truncated_tweet
      end
    
    else
      return full_tweet
    end
  
  end

  #convert score rating to stars
  def rating_to_star(score)
    stars_count = score / 20  
    remainder = score % 20 

    half_star = if remainder > 10
                  "★"
    elsif remainder > 0 && remainder <= 10
                  "½"
                else
                  ""
                end
    stars = "★" * stars_count + half_star
  end

end
