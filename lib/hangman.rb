require 'colored2'
require_relative 'messages.rb'

class Hangman
  include Messages
  attr_reader :secret_word
  DICTIONARY = File.readlines('google-10000-english-no-swears.txt')
              .map { |line| line.chomp }
              .select { |word| word.length >= 5 && word.length <= 12 }
  def initialize
    @secret_word = choose_word
    @guesses_remaining = 7
    @guessed_letters = ["a", "b", "c", "d"]
  end

  def setup
    introduction
  end 

  def letter_match?
  end

  def guess_letter
    select_letter
    @guessed_letters.each { |letter| print "#{letter.red} "}
    current_letter = gets.chomp
  end


  private

  def choose_word
    DICTIONARY.sample
  end

  

end

game = Hangman.new

game.guess_letter
