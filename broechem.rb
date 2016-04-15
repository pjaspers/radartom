# coding: utf-8
require "./boot"
require "sinatra/base"
require "tilt/erb"

class Broechem < Sinatra::Application

  get "/" do
    @tweet = Tweet.random_radar
    @reply = fetch_me_a_dotterism(tweet: @tweet)
    erb :index
  end

  def fetch_me_a_dotterism(tweet:)
    dotterisms.sample % {name: tweet.name}
  end

  def dotterisms
    ["¯\_(ツ)_/¯", "Sure", "Dooooomed", "(╯°□°）╯︵ ┻━┻)", "Ja %{name}. Ja."].freeze
  end
end
