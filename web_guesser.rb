require 'sinatra'
require 'sinatra/reloader'

RANDOM_NUMBER = rand(100)

get '/' do
	message, css_color = check_guess(params[:guess].to_i) if params[:guess]
  erb :index, :locals => {:random_number => RANDOM_NUMBER, message: message, css_color: css_color}
end

def check_guess(guess)
	case
	when guess == RANDOM_NUMBER 
		["You got it right! The secret number is #{RANDOM_NUMBER}", "green"]
	when guess > RANDOM_NUMBER+5 
		["Way too high", "red"]
	when guess > RANDOM_NUMBER 
		["Too high", "#FFDDDD"]
	when guess < RANDOM_NUMBER-5 
		["Way too low", "red"]
	when guess < RANDOM_NUMBER 
		["Too low", "#FFDDDD "]
	end
end