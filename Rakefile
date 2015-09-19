require "rubygems"
require "bundler/setup"

task :test do
  $LOAD_PATH.unshift("test")
  Dir.glob("./test/*_test.rb") { |f| require f }
end

task default: :test

desc "Search for new mentions"
task :crawl_for_tag do
  require "./dish"
  Dish.point_at_tom.crawl_hashtag
end

desc "Open an pry session with the app loaded"
task :console do
  require "pry"
  require "./boot"
  ARGV.clear
  Pry.start
end
