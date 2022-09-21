# frozen_string_literal: true

# Mastermind
module Mastermind
  COLORS = [1, 2, 3, 4, 5, 6].freeze # array of 6 colors (represented as nums 1-6)
end

# Game
class Game
  def initialize
    # game = #select_game - Give user choice to be code maker or code breaker (comment out at first).
    PlayBreaker.new(Player.new, Computer.new)

  end
end

# Play makes code
class PlayMaker < Game
  def initialize(player, comp)
    # Let player input 4 digits, store in array @code (convert string to array)
  end
end

# Player breaks code
class PlayBreaker < Game
  def initialize(player, comp)
    puts 'The computer has chosen a code. You have 12 attempts to guess it. Please input your first guess using 4 digits between 1-6:'
    @guess = gets.chomp
    puts "The computer says: #{comp.give_feedback(@guess.split(//).map(&:to_i))}"

    # times = 0
    # 	Send @guess to Computer.give_feedback(@guess, [])
    # 	times +=1
    # 	until feedback is 'XXXX' or count is 12
    # if feedback is XXXX
    # 	say you guessed correctly!
    # else
    # 	print you've run out of guesses! better luck next time :)
  end
end

# Player
class Player
  attr_reader :mode # make or break
end

# Computer
class Computer
  include Mastermind
  def initialize
    @code = Array.new(4) { COLORS.sample } # generate random code using 6 colors
  end

  def give_feedback(guess, fb = [])
    p @code.join
    # check guess against code and shuffle resulting feedback
    guess.each_with_index do |color, i|
      case @code.count(color)
      when 0
        next
      when 1
        if i == @code.index(color)
          fb.push('X')
        else
          fb.push('O')
        end
      else
        if @code[i] == color
          fb.push('X')
        else
          fb.push('O')
        end
      end
    end
    fb.join
  end
end



#select_game
  # print choose your role
  # choice = gets.chomp
  # until choice = 1 || choice == 2
  # 	please input 1 or 2
  # 	choice = gets.chomp
  # end
  # choice == 1 ? play_maker : play_breaker

#run_maker(player)
  # print instructions (choose 4 digits)
  # get digits & verify input, store in secret variable "code" (not accessible to Computer)
  # Computer.new()

# #process_guess
# 	guess = Computer.make_guess




Game.new
