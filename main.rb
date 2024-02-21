# ASCII representaion of board
# make computer generate code
# make random number generator from 1 to 6
# make hash with numbers corrosponding to their colors
# loop ask player for code until:
# code is correct or turn 12
# issue: @code of cpu has a color in each item, player_guesses has entire guess in each item
# split answer of player and put in new hash
# compare that hash to @code
# also put that guess in the player_guesses hash
# use player_guesses hash to display on board later
module RandomColors
  def generate_color
    colors = {1 => 'red', 2 => 'blue', 3 => 'yellow', 4 => 'green', 5 => 'brown', 6 => 'purple'}
    colors[rand(1..6)]
  end
end

class Player
  player_guesses = {}
  (1..12).each do |a|
    string = gets.chomp
    player_guess = {}
    string.split.each_with_index do |word, index|
      player_guess[index + 1] = word
    end
    player_guesses[a] = string
    break if player_guess == @code
  end
end

class Board < Player
  include RandomColors
  attr_accessor :code
  def initialize
    super
    @code = {1 => generate_color, 2 => generate_color, 3 => generate_color, 4 => generate_color}
  end

  def display_board
    puts "|| |EEEE| \n" + 
         "|| |EEEE| \n" +
         "|| |EEEE| \n" +
         "|| |EEEE| \n" +
         "|| |EEEE| \n" +
         "|| |EEEE| \n" +
         "|| |EEEE| \n" +
         "|| |EEEE| \n" +
         "|| |EEEE| \n" +
         "|| |EEEE| \n" +
         "|| |EEEE| \n" +
         "|| |EEEE| \n" 
  end
end

board = Board.new
board.display_board
board.code
