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
    # need to parse out into a loop method
    introduction
    guess_letter
    assign_letters if letter_match?
    display_correctly_guessed
  end 

  def letter_match?
    @secret_word.any?(@current_letter)
  end

  def display_correctly_guessed
    # need to refactor to print prettier
    print @blanks_to_fill
  end

  # will have loop do assign letters IF letter_match?
  def assign_letters
    @secret_word.each_with_index do |letter, index|
      @blanks_to_fill[index] = @current_letter if letter == @current_letter
    end
  end
  
  # need a method that checks for incorrect guesses


  # need a method that takes a turn away for incorrect guesses

  # need a method that saves the game
    #YAML.dump

  # need a method that loads a game
    #YAML.load

  def guess_letter
    select_letter
    @guessed_letters.each { |letter| print "#{letter.red} "}
    @current_letter = gets.chomp
  end



  private

  def choose_word
    DICTIONARY.sample.split('')
  end

  

end

game = Hangman.new

game.setup
# puts game.secret_word
# puts game.blanks_to_fill

# game.guess_letter

# game.assign_letters

# print game.blanks_to_fill


