ENV["RACK_ENV"] = "test"
require "minitest/autorun"
require "minitest/pride"
require "rack/test"
require "pry"

require File.expand_path "../../broechem.rb", __FILE__

include Rack::Test::Methods

def app
  Broechem
end

class AppTest < Minitest::Test

  def test_renders_front_page
    get "/"
    assert_equal 200, last_response.status
  end

end
