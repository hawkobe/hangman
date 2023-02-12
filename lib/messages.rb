module Messages
  def introduction
    puts <<~HEREDOC
    Welcome to Hangman! The classic game that allows you to #{"SAVE LIVES".red}
    by correctly guessing a word before running out of guesses.

    You will be playing against the computer, and it will randomly select a word
    between #{"5 and 12".red} letters, with no swears or proper nouns.

    Each turn, you will select one letter, and if it matches a letter in the
    computer's secret word, it will be revealed and you won't get docked for
    and #{"incorrect guess".red}.

    You will have 7 guesses (#{"one extra cuz we're nice".underlined}) to correctly
    guess the word the computer has chosen. Good luck!

    Would you like to start a game from scratch, or load a saved game?

    [1] Start from scratch
    [2] Load game

    HEREDOC
  end

  def select_letter
    puts "\nPlease select a letter for your guess."
  end

  def list_incorrect
    print "\nHere is a list of what has already been chosen incorrectly: "
  end

  def correct_letters
    print "\nHere's what you have guessed correctly: "
  end

  def guesses_left(number_of_guesses)
    puts "You have #{number_of_guesses} incorrect guesses left"
  end

  def incorrect_selection
    puts "You have entered an invalid letter,"
    puts "it has either already been chosen or is longer than a single letter"
  end
  
  def initial_guess
    puts "\nThat's how many letters the word has. Now it's time to fill it in!"
  end

  def player_loss(word)
    puts "Blast! The computer outsmarted you... this time."
    puts "The secret word was #{word}"
  end

  def player_win
    puts "You guessed the word. You are the SMARTEST"
  end

  def ask_save
    puts "\nWould you like to save your game?"
    puts "Enter 'Y' or 'y' to save, or enter to continue"
  end

  def save_name
    puts "Please enter a name for your saved game"
  end

  def exit_prompt
    puts "\nWould you like to exit the game?"
    puts "Type 'exit' to exit, or enter to continue"
  end

  def game_loaded
    puts "\nAlright, let's pick up where we left off"
  end
end
