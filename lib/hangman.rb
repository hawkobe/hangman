class Hangman
  def initialize
    @dictionary = File.readlines('google-10000-english-no-swears.txt')
  end
end

