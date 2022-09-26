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
    until [1, 2].include?(choice)
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
    times = 1
    feedback = ''
    while times <= 12
      puts "Round #{times}, AI guesses #{guess = @comp.make_guess(feedback, times)}."
      break if @player.code_is(guess)

      feedback = @player.give_feedback(guess)
      times += 1
      puts 'You stumped the AI!' if times == 13
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

# Player
class Player
  def make_code
    puts 'Please input 4 digits between 1-6 for the computer to guess:'
    @code = gets.chomp.split('')
    @code.each_with_index { |col, i| @code[i] = col.to_i }
  end

  def code_is(guess)
    guess.eql?(@code)
  end

  def give_feedback(guess, feedback = '')
    temp = @code.map(&:clone)
    guess = guess.map(&:clone)
    temp.each_with_index do |color, i|
      if guess[i] == color
        feedback += 'X'
        temp[i] = 0
        guess[i] = -1
      elsif guess.any?(color)
        feedback += 'O'
        temp[i] = 0
        guess[guess.index(color)] = -1
      end
    end
    feedback.split('').shuffle.join
  end
end

# Computer Code Maker
class CompCodeMaker
  include Mastermind

  def initialize
    @code = Array.new(4) { COLORS.sample } # generate random code using 6 colors
  end

  def give_feedback(guess, feedback = '')
    temp = @code.map(&:clone)
    temp.each_with_index do |color, i|
      if guess[i] == color
        feedback += 'X'
        temp[i] = 0
        guess[i] = -1
      elsif guess.any?(color)
        feedback += 'O'
        temp[i] = 0
        guess[guess.index(color)] = -1
      end
    end
    feedback.split('').shuffle.join
  end
end

# Computer Code Breaker
class CompCodeBreaker
  def initialize
    create_guess_list
    @guess = [1, 1, 2, 2]
  end

  def create_guess_list
    @list = []
    a = [1, 2, 3, 4, 5, 6]
    a.repeated_permutation(4) { |permutation| @list.push(permutation) }
  end

  def make_guess(feedback, times)
    return @guess if times == 1

    clean_up_list(feedback)
    # Pick the first element in the list and use it as new guess.
    @guess = @list.first
  end

  def clean_up_list(feedback)
    feedback = feedback.chars.sort.join
    @list.each_with_index do |item, i|
      temp_item = item.map(&:clone)
      temp_guess = @guess.map(&:clone)
      fb = check_list_item(temp_item, temp_guess)
      @list.delete_at(i) unless fb == feedback
    end
  end

  def check_list_item(item, guess, fb = '')
    item.each_with_index do |color, i|
      if guess[i] == color
        fb += 'X'
        guess[i] = 0
        item[i] = -1
      elsif guess.any?(color)
        fb += 'O'
        item[i] = 0
        guess[guess.index(color)] = -1
      end
    end
    fb.chars.sort.join
  end
end

Game.new
