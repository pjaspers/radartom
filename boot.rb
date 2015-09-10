require "rubygems"
require "bundler/setup"
require "sequel"
begin
  require "dotenv"
  Dotenv.load
rescue LoadError
  # Only needed in develop
end

$db = Sequel.connect(ENV["DATABASE_URL"] || "sqlite://dotter.db")

$db.create_table? :tweets do
  primary_key :id
  String :name
  String :text
  Time :posted_at
  String :tweet_id
  String :profile_image
end

class Tweet < Sequel::Model;
  def high_quality_profile_image
    return "" unless profile_image
    profile_image.gsub("_normal", "_400x400")
  end

  # Fetchez a random tweet or fallback to one of Tom's.
  def self.random_radar
    all.sample || null
  end

  # If we don't find any tweets with #radartom fallback to a quote by regular Tom.
  # Such knowledge. Much amaze.
  #
  # Returns a Tweet
  def self.null
    text = <<DESC
"Fighting with all my dev tools today.

ALL THE FUN. #radartom"
DESC
    Tweet.new(name: "Inferis",
              text: text,
              tweet_id: "641994864037601280",
              profile_image: "https://pbs.twimg.com/profile_images/476829051194462208/3xG9k9j-_400x400.jpeg")
  end
end
