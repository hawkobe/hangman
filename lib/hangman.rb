require 'colored2'
require_relative 'messages.rb'

class Hangman
  include Messages
  attr_reader :secret_word, :blanks_to_fill
  attr_accessor :current_letter
  DICTIONARY = File.readlines('google-10000-english-no-swears.txt')
              .map { |line| line.chomp }
              .select { |word| word.length >= 5 && word.length <= 12 }

  def initialize
    @secret_word = choose_word
    @guesses_remaining = 7
    @guessed_letters = []
    @current_letter = nil
    @blanks_to_fill = Array.new(@secret_word.length, "_")
  end

  def setup
    introduction
  end 

  def game_loop
    until @guesses_remaining == 0
      guess_letter
      letter_match? ? assign_letters : deduct_guess
      display_correct
      guesses_left(@guesses_remaining.to_s.red)
    end 
  end

  def letter_match?
    @secret_word.any?(@current_letter)
  end

  def letter_available?(letter)
    @guessed_letters.none?(letter) && letter.match?(/^[a-z]{1}$/)
  end

  def display_correct
    correct_letters
    puts @blanks_to_fill.join(" ").cyan
  end

  def assign_letters
    @secret_word.each_with_index do |letter, index|
      @blanks_to_fill[index] = @current_letter if letter == @current_letter
    end
  end

  def display_incorrect
    puts @guessed_letters.join(" ").red
  end

  def deduct_guess
    @guesses_remaining -= 1
  end


  # need a method that saves the game
    #YAML.dump

  # need a method that loads a game
    #YAML.load

  def guess_letter
    select_letter
    display_incorrect
    @current_letter = gets.chomp.downcase
    until letter_available?(@current_letter)
      incorrect_selection
      @current_letter = gets.chomp.downcase
    end
    @guessed_letters << @current_letter
  end



  private

  def choose_word
    DICTIONARY.sample.split('')
  end

  

end

game = Hangman.new

game.setup
game.game_loop
# puts game.secret_word
# puts game.blanks_to_fill

# game.guess_letter

# game.assign_letters

# print game.blanks_to_fill


