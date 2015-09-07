require "./boot"
require "sinatra/base"

class Broechem < Sinatra::Application

  get "/" do
    erb :index
  end
end
