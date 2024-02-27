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

module CodeMaker
  include RandomColors
  include DisplayBoard
  def code_maker
    pegs = []
    @player_code = gets.chomp
    past_guess = []
    (1..12).each do
      computer_guess = [generate_color, generate_color, generate_color, generate_color]
      if !pegs.empty? 
        past_guess.shuffle!
        (0..pegs.length).each do |a|
          computer_guess[a] = past_guess[a] 
        end
      end
      past_guess = computer_guess
      display_board(computer_guess, pegs)
      if computer_guess == @player_code
        break
      else
        puts 'any hints?'
        pegs = []
        pegs << gets.chomp
      end
    end
  end
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
