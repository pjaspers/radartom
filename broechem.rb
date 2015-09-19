# coding: utf-8
require "./boot"
require "sinatra/base"
require "tilt/erb"

class Broechem < Sinatra::Application

  get "/" do
    @tweet = Tweet.random_radar
    @reply = dotterisms.sample
    erb :index
  end

  def dotterisms
    ["¯\_(ツ)_/¯", "Sure", "Dooooomed", "(╯°□°）╯︵ ┻━┻)"]
  end
end
