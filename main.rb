require_relative 'controllers/movie_review_controller'
require_relative 'views/tweet_view'

review_file = 'data/reviews.json'
movie_file = 'data/movies.json'

controller = MovieReviewController.new(review_file, movie_file)
tweets = controller.generate_tweets

view = TweetView.new
view.display_tweets(tweets)
