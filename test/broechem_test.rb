ENV["RACK_ENV"] = "test"
require "minitest/autorun"
require "minitest/pride"
require "rack/test"
require "pry"

ENV['DATABASE_URL'] = 'sqlite://test_dotter.db'
require File.expand_path "../../broechem.rb", __FILE__

include Rack::Test::Methods

def app
  Broechem
end

def setup_tweet
  Tweet.create(name: "bobvlanduyt", text: "I broke the tests.", tweet_id: "641623559224324096", profile_image: "https://pbs.twimg.com/profile_images/1175219771/Foto_3.jpg")
end

class Minitest::Test
  alias_method :_original_run, :run

  def run(*args, &block)
    result = nil
    Sequel::Model.db.transaction(:rollback => :always, :auto_savepoint=>true) do
      result = _original_run(*args, &block)
    end
    result
  end
end

class AppTest < Minitest::Test

  def test_renders_front_page
    setup_tweet
    get "/"
    assert_equal 200, last_response.status
  end

  def test_renders_front_page_without_tweets
    get "/"
    assert_equal 200, last_response.status
  end
end
