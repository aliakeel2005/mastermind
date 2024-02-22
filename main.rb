# ASCII representaion of board
# make computer generate code
# make random number generator from 1 to 6
# make hash with numbers corrosponding to their colors
# loop ask player for code until:
# code is correct or turn 12
# issue: @code of cpu has a color in each item, player_guesses has entire guess in each item
# split answer of player and put in player_guess array
# compare the array to @code, if matching, end game
# also put that guess in the player_guesses array
# use player_guesses array to display on board later
module RandomColors
  def generate_color
    colors = {1 => 'red', 2 => 'blue', 3 => 'yellow', 4 => 'green', 5 => 'brown', 6 => 'purple'}
    colors[rand(1..6)]
  end
end

class Player
  def game_begin
    player_guesses = []
    (1..12).each do |a|
      string = gets.chomp # "yellow, red, blue"
      player_guess = string.split # ["yellow", "red", "blue"]
      player_guesses[a] = string # ["yellow, red, blue"]
      break if player_guess == @code
    end
  end
end

class Board < Player
  include RandomColors
  attr_accessor :code

  def initialize
    super
    @code = [generate_color, generate_color, generate_color, generate_color]
  end

  def show_code
    puts @code
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
board.show_code
board.game_begin