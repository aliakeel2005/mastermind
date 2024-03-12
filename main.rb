# make computer_guess variable # add each guess of @first_guesses to it
# add

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

module ColorMapping
  def create_map
   @color_mapping = { 'red' => 1,
                     'blue' => 2,
                     'yellow' => 3,
                     'green' => 4,
                     'brown' => 5,
                     'purple' => 6 }
  end
end


class CodeMaker
  include RandomColors
  include DisplayBoard
  include ColorMapping
  def initialize
    create_map
    @pegs = 0
    @current_pegs = 0
    @first_guesses = [[1,1,1,1],[2,2,2,2],[3,3,3,3],[4,4,4,4],[5,5,5,5],[6,6,6,6]]
    @possible_guesses = (1..6).to_a.repeated_permutation(4).to_a
  end

  def remove_guesses(mapped_code, guess)
    @current_pegs = mapped_code.count { |element| guess.include?(element) }
    @possible_guesses = @possible_guesses.select { |array| array.count(guess[1]) >= @current_pegs }
    @possible_guesses
  end

  def random_guesses(turns, mapped_code)
    game_on = true
    while turns >= 0 && game_on
      break if turns.zero?

      @possible_guesses.each do |a|
        turns -= 1
        if a == mapped_code
          puts "the computer guesses your code correctly on turn #{turns}! #{a}"
          game_on = false
        end
        break if turns.zero? || a == mapped_code

        puts "turn:#{turns}, the computer tries to guess! #{a}"
      end
    end
  end

  def guess_the_code(mapped_code)
    turns = 12
    while turns >= 0
      break if turns.zero? || @pegs == 4

      @first_guesses.map do |guess| # current issue: remove however many pegs you get from the current guess from possible_guesses
        turns -= 1
        puts "current guess: #{guess}, current turn: #{turns}"
        remove_guesses(mapped_code, guess)
        @pegs += mapped_code.count { |element| guess.include?(element) } # maybe make it a module
        if @pegs == 4
          puts "end"
          p @pegs
          break
        end
      end
    end
    random_guesses(turns, mapped_code)
  end

  def start_game
    puts 'make your code for the computer to guess!'
    string = gets.chomp.split
    mapped_code = string.map { |colors| @color_mapping[colors] } # use mapped_code for swazeki algorithm
    guess_the_code(mapped_code)
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
  # include CodeMaker

  def initialize
    super
    @code = [generate_color, generate_color, generate_color, generate_color]
  end
end
board = Board.new
test = CodeMaker.new
test.start_game
# puts '1- code breaker 2- code maker'
# if gets.chomp == '1'
#   board.game_begin
# else
#   board.code_maker
# end
