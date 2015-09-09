require "./boot"
require "sinatra/base"

class Broechem < Sinatra::Application

  get "/" do
    @tweet = Tweet.all.sample
    @reply = dotterisms.sample
    erb :index
  end

  def dotterisms
    ["¯\_(ツ)_/¯", "Sure", "Dooooomed", "(╯°□°）╯︵ ┻━┻)"]
  end
end
