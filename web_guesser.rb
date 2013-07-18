require 'sinatra'
require 'sinatra/reloader'

random_number = rand(100)

get '/' do
	guess = params[:guess].to_i
  erb :index, :locals => {:random_number => random_number, guess: guess}
end