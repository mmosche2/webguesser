require 'sinatra'
require 'sinatra/reloader'

RANDOM_NUMBER = rand(100)

get '/' do
	message = check_guess(params[:guess].to_i) if params[:guess]
  erb :index, :locals => {:random_number => RANDOM_NUMBER, message: message}
end

def check_guess(guess)
	case
	when guess == RANDOM_NUMBER then "You got it right! The secret number is #{RANDOM_NUMBER}"
	when guess > RANDOM_NUMBER+5 then "Way too high"
	when guess > RANDOM_NUMBER then "Too high"
	when guess < RANDOM_NUMBER-5 then "Way too low"
	when guess < RANDOM_NUMBER then "Too low"
	end
end