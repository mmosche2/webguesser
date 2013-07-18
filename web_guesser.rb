require 'sinatra'
require 'sinatra/reloader'

RANDOM_NUMBER = rand(100)
@@remaining_guesses = 5
@@correct = false

get '/' do
	cheat_mode = params[:cheat]
	message, css_color = check_guess(params[:guess].to_i) if params[:guess]
	if @@remaining_guesses == 1 && !@@correct
		RANDOM_NUMBER = rand(100)
		@@remaining_guesses = 5
		message = "you lost"
		css_color = "red"
	elsif @@correct
		RANDOM_NUMBER = rand(100)
		@@correct = false
		@@remaining_guesses = 5
	else #not last turn and got it wrong
		@@remaining_guesses -= 1
  end
  erb :index, :locals => {:random_number => RANDOM_NUMBER, message: message, css_color: css_color,
  													cheat_mode: cheat_mode, count: @@remaining_guesses}
end

def check_guess(guess)
	case
	when guess == RANDOM_NUMBER 
		@@correct = true
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
