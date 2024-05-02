require_relative '../controllers/movie_review_controller'
require 'faker'

RSpec.describe MovieReviewController do
  let(:controller) { MovieReviewController.new("../data/reviews.json", "../data/movies.json") }

  describe "#generate_tweets" do
  let(:reviews) do
    Array.new(5) do
      MovieReview.new(
        Faker::Movie.title,
        #Faker::Lorem.characters(number: Faker::Number.between(from: 10, to: 190)),
        Faker::Lorem.sentence(word_count: rand(1..40)),
        Faker::Number.between(from: 1, to: 100),
        Faker::Number.between(from: 1900, to: 2024)
      )
    end
  end

  let(:movies) do
    reviews.map do |review|
      { "title" => review.title, "year" => review.year }
    end
  end

  before do
    allow(controller).to receive(:read_reviews).and_return(reviews)
    allow(controller).to receive(:read_movies).and_return(movies)
  end

  it "generates correct tweets with length less than or equal to 140" do
    reviews = controller.read_reviews
   # Print review tweets before calling the controller method
   puts "tweets before calling controller method generate_tweets:"
   reviews.each do |review|
      tweet = "#{review.title} (#{review.year}): #{review.review} #{controller.send(:rating_to_star, review.score)}"
      puts "tweet: #{tweet} and length: #{tweet.length}"
   end

   tweets = controller.generate_tweets
   puts "tweets after calling controller method generate_tweets:"
   tweets.each { |tweet| puts "tweet: #{tweet} and length: #{tweet.length}" }
   expect(tweets).to all(satisfy { |tweet| tweet.length <= 140 })
  end

end

describe "#rating_to_star" do
  it "returns correct star representation for score" do
    score = Faker::Number.between(from: 1, to: 100)
    stars_count = score / 20
    remainder = score % 20

    expected_stars = "★" * stars_count
    expected_stars += "★" if remainder > 10
    expected_stars += "½" if remainder > 0 && remainder <= 10
    puts "Score: #{score} and Rating: #{expected_stars}"
    expect(controller.send(:rating_to_star, score)).to eq(expected_stars)
  end
end
end