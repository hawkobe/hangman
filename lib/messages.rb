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
end
