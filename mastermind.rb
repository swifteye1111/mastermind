# frozen_string_literal: true

# Mastermind
class Game
	COLORS = [1,2,3,4,5,6] #array of 6 colors (represented as nums 1-6)

end

class Player
	def mode (make or break)
  end
end

class Computer
end

game = game.New()
= [a.sample(4, random: Random.new(1))  #=> [6, 10, 9, 2]

Game
	initialize
		game = #select_game - Give user choice to be code maker or code breaker (comment out at first).
		run_maker(player, Computer.new(break) run_breaker(player, Computer.new(make))
			
	#select_game
		print choose your role
		choice = gets.chomp
		until choice = 1 || choice == 2
			please input 1 or 2
			choice = gets.chomp
		end
		choice == 1 ? play_maker : play_breaker
		
	#run_maker(player)
		print instructions (choose 4 digits)
		get digits & verify input, store in secret variable "code" (not accessible to Computer)
		Computer.new()
		
	#process_guess
		guess = Computer.make_guess
		
	
	
	#run_breaker(player, comp)
		Let player input 4 digits, store in array @guess
		times = 0
			Send @guess to Computer.give_feedback(@guess) 
			times +=1 
			until feedback is 'XXXX' or count is 12
		if feedback is XXXX
			say you guessed correctly!
		else
			print you've run out of guesses! better luck next time :)
		
		
		
=begin
Computer
	#initialize
		CODE = #make_code
		
	#make_code
		Computer randomly generates 4 successive colors (from 6 colors array), returns
	
	private
	
	#give_feedback(guess)
		feedback array
		#Process guess against CODE:
		guess.each_with_index |color, i|
			case CODE.count(color)
			when 0
				next
			when 1
				if i = CODE.index(color)
					add 'X' to feedback array
				else
					add 'O' to feedback_array
				end
			else
				if there are more than one, then if CODE[i] = color
					add X
				otherwise,
					add O
			end
		end
			
			j = temp.index(color)
				if i = j	add 'X' to feedback array
				else 		add 'O' to feedback array,
				remove an instance of color from temp (temp[j] = 0) 
		return feedback.shuffle
=end