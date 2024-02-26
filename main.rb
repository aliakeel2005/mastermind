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
# issue: display_board too big, make it display one row per turn
# DsplayBoard is now a module
# simply adds the player string into the string and displays it
# if player
module RandomColors
  def generate_color
    colors = %w[red blue yellow green brown purple]
    colors[rand(0..5)]
  end
end

module DisplayBoard
  def display_board(player, pegs)
    puts "|#{pegs.shuffle.join}| |#{player}|"
  end
end

module Pegs
  def add_pegs(string, player_guess)
    pegs = []
    @code.each_with_index do |color, index|
      if color == player_guess[index]
        pegs << '#'
      elsif player_guess.include?(color)
        pegs << '*'
      end
    end
    display_board(string, pegs)
  end
end

class Player
  include DisplayBoard
  include Pegs
  def game_begin
    (1..12).each do |a|
      string = gets.chomp # "yellow, red, blue"
      player_guess = string.split # ["yellow", "red", "blue"] [purple, blue, green]
      add_pegs(string, player_guess)
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
    puts @code # debug method
  end
end
board = Board.new
board.show_code
board.game_begin
