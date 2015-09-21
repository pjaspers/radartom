require "helper"
require File.expand_path "../../broechem.rb", __FILE__

def app
  Broechem
end

def setup_tweet
  Tweet.create(name: "bobvlanduyt", text: "I broke the tests.", tweet_id: "641623559224324096", profile_image: "https://pbs.twimg.com/profile_images/1175219771/Foto_3.jpg")
end

class BroechemTest < Minitest::Test
  include Rack::Test::Methods

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
