# movie_review.rb
# MovieReview class represents a movie review
class MovieReview
    attr_reader :title, :review, :score, :year
  
    # Initialize a MovieReview object with title, review, and score
    def initialize(title, review, score, year)
      @title = title
      @review = review
      @score = score
      @year = year
    end
  end
  