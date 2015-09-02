require "rubygems"
require "bundler/setup"
require "dotenv"
require "dotenv/tasks"

task :test do
  $LOAD_PATH.unshift("test")
  Dir.glob("./test/*_test.rb") { |f| require f }
end

task default: :test

desc "Open an pry session with the app loaded"
task :console do
  require "pry"
  require "./boot"
  ARGV.clear
  Pry.start
end
