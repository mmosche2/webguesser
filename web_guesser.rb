require 'sinatra'
require 'sinatra/reloader'

RANDOM_NUMBER = rand(100)
@@remaining_guesses = 5

get '/' do
	if @@remaining_guesses == 0
		RANDOM_NUMBER = rand(100)
		@@remaining_guesses = 5
		# display lost message
		erb :index, :locals => {:random_number => RANDOM_NUMBER, message: "you lost", css_color: "red"}
	else 
		@@remaining_guesses = @@remaining_guesses - 1
		message, css_color = check_guess(params[:guess].to_i) if params[:guess]
		RANDOM_NUMBER = rand(100) if @@remaining_guesses == 5
  	erb :index, :locals => {:random_number => RANDOM_NUMBER, message: message, css_color: css_color}
  end
end

def check_guess(guess)
	case
	when guess == RANDOM_NUMBER 
		@@remaining_guesses = 5
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
