# frozen_string_literal: true

# Mastermind
module Mastermind
  COLORS = [1, 2, 3, 4, 5, 6].freeze # array of 6 colors (represented as nums 1-6)
end

# Game
class Game
  def initialize
    # game = #select_game - Give user choice to be code maker or code breaker (comment out at first).
    player = Player.new('break')
    PlayBreaker.new(player, Computer.new)

  end
end

# Play makes code
class PlayMaker
  def initialize(player, comp)
    # Let player input 4 digits, store in array @code (convert string to array)
  end
end

# Player breaks code
class PlayBreaker
  def initialize(player, comp)
    @player = player
    @comp = comp
    play_game
  end
  
  def play_game
    puts 'The computer has chosen a code. You have 12 attempts to guess it. Please input your first guess using 4'\
      ' digits between 1 and 6.'
    times = 0
    until times == 12
      times += 1
      @guess = gets.chomp 
      break unless eval_feedback(@comp.give_feedback(@guess.split(//).map(&:to_i)), times) == 'next'
    end
  end

  def eval_feedback(feedback, times)
    puts "The computer says: #{feedback}"
    if feedback == 'XXXX'
      declare_victory(times)
    elsif times == 12
      puts '0 tries left. Better luck next time!'
    else
      puts "Number of tries left: #{12 - times}. Make your next guess:"
      'next'
    end
  end

  def declare_victory(num)
    if num > 10 then puts "You guessed it in #{num} tries, just in the nick of time!"
    elsif num > 6 then puts "You guessed it in #{num} tries! Great job!"
    elsif num > 1 then puts "Wow, you guessed it in #{num} tries. That's amazing!"
    else
      puts 'What luck! You guessed it the first time!'
    end
  end
end

# Player
class Player
  attr_reader :mode # make or break

  def initialize(mode)
    @mode = mode
  end
end

# Computer
class Computer
  include Mastermind
  def initialize
    @code = Array.new(4) { COLORS.sample } # generate random code using 6 colors
  end

  def give_feedback(guess, feedback = [])
    p @code.join
    guess.each_with_index do |color, i|
      case @code.count(color)
      when 0 then next
      when 1 then feedback.push(i == @code.index(color) ? 'X' : 'O')
      else feedback.push(@code[i] == color ? 'X' : 'O')
      end
    end
    feedback.shuffle.join
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
