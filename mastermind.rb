# frozen_string_literal: true

# Mastermind
module Mastermind
  COLORS = [1, 2, 3, 4, 5, 6].freeze # array of 6 colors (represented as nums 1-6)
end

# Game
class Game
  def initialize
    if select_game == 'breaker'
      PlayBreaker.new(Player.new, CompCodeMaker.new)
    else
      PlayMaker.new(Player.new, CompCodeBreaker.new)
    end
  end

  def select_game
    puts 'Choose your role: code maker (1) or code breaker (2)?'
    choice = gets.chomp.to_i
    until choice == 1 || choice == 2
      puts 'Please input 1 or 2:'
      choice = gets.chomp.to_i
    end
    choice == 1 ? 'maker' : 'breaker'
  end
end

# Play makes code
class PlayMaker
  def initialize(player, comp)
    # Let player input 4 digits, store in array @code (convert string to array)
    @player = player
    @comp = comp
    player.make_code

    play_game
  end

  def play_game
    times = 0
    guess = %w[0 0 0 0]
    while times < 12
      break if @player.code_is(guess)

      feedback = @player.give_feedback(guess)
      puts feedback
      guess = @comp.make_guess(feedback)
      times += 1
    end
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

# Entity
class Entity
  def give_feedback(guess, feedback = [])
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

# Player
class Player < Entity
  def make_code
    puts 'Please input 4 digits between 1-6 for the computer to guess:'
    @code = %w[1 2 3 4] # gets.chomp.split(//)
  end

  def code_is(guess)
    guess.eql?(@code)
  end
end

# Computer Code Maker
class CompCodeMaker < Entity
  include Mastermind

  def initialize
    super
    @code = Array.new(4) { COLORS.sample } # generate random code using 6 colors
  end
end

# Computer Code Breaker
class CompCodeBreaker < Entity
  def initialize
    super
    create_guess_list
    @guess = %w[1 1 2 2]
  end

  def make_guess(feedback)
    @guess
  end

  def create_guess_list
    @list = []
    num = 1111
    while num < 6667
      puts num.to_s.split(//)
      @list.push(num.to_s.split(//))
      num += 1
    end
  end
end

Game.new
