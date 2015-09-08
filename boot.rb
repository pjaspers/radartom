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

class Tweet < Sequel::Model; end
