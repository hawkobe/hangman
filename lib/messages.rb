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
    HEREDOC
  end

  def select_letter
    puts "\nPlease select a letter for your guess."
    print "Here is a list of what has already been chosen: "
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
  
end
