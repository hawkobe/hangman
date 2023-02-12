require 'colored2'
require 'yaml'
require_relative 'messages.rb'


class Hangman
  include Messages
  DICTIONARY = File.readlines('google-10000-english-no-swears.txt')
              .map { |line| line.chomp }
              .select { |word| word.length >= 5 && word.length <= 12 }

  def initialize
    @secret_word = choose_word
    @guesses_remaining = 7
    @guessed_letters = []
    @incorrectly_guessed_letters = []
    @current_letter = nil
    @blanks_to_fill = Array.new(@secret_word.length, "_")
  end

  def setup
    introduction
  end 

  def game_loop
    until @guesses_remaining == 0 || game_won?
      guess_letter
      letter_match? ? assign_letters : deduct_guess
      display_correct
      guesses_left(@guesses_remaining.to_s.red) unless game_won?
      save_game
    end 
  end

  def play
    setup
    load_or_start_new
    puts "\n#{@blanks_to_fill.join(" ").cyan}"
    initial_guess
    game_loop
    game_won? ? player_win : player_loss(@secret_word.join('').cyan.underlined)
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
    if @incorrectly_guessed_letters.any?
      list_incorrect
      puts @incorrectly_guessed_letters.join(" ").red
    end
  end

  def deduct_guess
    @guesses_remaining -= 1
    @incorrectly_guessed_letters << @current_letter
  end

  def game_won?
    @blanks_to_fill.none?('_')
  end

  def save_game
    ask_save
    response = gets.chomp
    if response == 'Y' || response == 'y'
      Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
      yaml = YAML.dump ({
        :secret_word => @secret_word,
        :guesses_remaining => @guesses_remaining,
        :guessed_letters => @guessed_letters,
        :incorrectly_guessed_letters => @incorrectly_guessed_letters,
        :current_letter => @current_letter,
        :blanks_to_fill => @blanks_to_fill
      })
      
      save_name
      filename = gets.chomp 

      File.open("saved_games/#{filename}.yaml", 'w') do |file|
        file.write yaml
      end

      exit_prompt
      response = gets.chomp
      exit if response == 'exit'
    end
  end

  def load_game(filename)
    game_file = File.open("saved_games/#{filename}.yaml", 'r')
    # yaml = game_file.read
    data = YAML.load(game_file.read)
    # @secret_word = data[:secret_word],
    # @guesses_remaining = data[:guesses_remaining],
    # @guessed_letters = data[:guessed_letters],
    # @incorrectly_guessed_letters = data[:incorrectly_guessed_letters],
    # @current_letter = data[:current_letter],
    # @blanks_to_fill = data[:blanks_to_fill]

    # game_loaded
    # game_loop
    data
  end

  # write a method that gives the player ONE LAST
  # chance to guess the WHOLE word

  def guess_letter
    display_incorrect
    select_letter
    @current_letter = gets.chomp.downcase
    until letter_available?(@current_letter)
      incorrect_selection
      @current_letter = gets.chomp.downcase
    end
    @guessed_letters << @current_letter
  end

  def display_saved_games
    puts Dir.glob('saved_games/*')
         .join("\n")
         .delete_prefix('saved_games/')
         .delete_suffix('.yaml')
  end

  def load_or_start_new
    response = gets.chomp
    until response == '1' || response == '2'
      puts "That isn't a specified option, please select either 1, or 2"
      response = gets.chomp
    end
    if response == '2'
      if Dir.exist?('saved_games')
        puts "\nPlease select a game from the list you'd like to load:"
        display_saved_games
        file_to_load = gets.chomp
        load_game(file_to_load)
      else
        puts "There aren't any saved games to load, let's start a new one"
        play
      end
    end
  end
  private

  def choose_word
    DICTIONARY.sample.split('')
  end

  

end

game = Hangman.new

game.play