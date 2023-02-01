require 'colored2'
require_relative 'messages.rb'

class Hangman
  include Messages
  attr_reader :dictionary
  def initialize
    @dictionary = File.readlines('google-10000-english-no-swears.txt').map do |line|
      line.chomp
    end
  end
end

game = Hangman.new