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

class ColorMapping
  @color_mapping = { 'red' => 1,
                     'blue' => 2,
                     'yellow' => 3,
                     'green' => 4,
                     'brown' => 5,
                     'purple' => 6 }
end


module CodeMaker
  include RandomColors
  include DisplayBoard
  possible_guesses = (1..6).to_a.repeated_permutation(4).to_a
  
end


class CodeBreaker
  include DisplayBoard
  include Pegs
  def game_begin
    (1..12).each do
      string = gets.chomp
      player_guess = string.split
      add_pegs(string, player_guess)
      break if player_guess == @code
    end
    puts "the code was #{@code}"
  end
end

class Board < CodeBreaker
  include RandomColors
  include CodeMaker

  def initialize
    super
    @code = [generate_color, generate_color, generate_color, generate_color]
  end
end
board = Board.new
puts '1- code breaker 2- code maker'
if gets.chomp == '1'
  board.game_begin
else
  board.code_maker
end
