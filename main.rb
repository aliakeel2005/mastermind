module RandomColors
  COLORS = %w[red blue yellow green brown purple]
  def generate_color
    COLORS[rand(0..5)]
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

  def unmap(guess, mapped_code)
    guess.map { |a| mapped_code.key(a) }
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
    @first_guesses = [[1, 1, 1, 1], [2, 2, 2, 2], [3, 3, 3, 3], [4, 4, 4, 4], [5, 5, 5, 5], [6, 6, 6, 6]]
    @possible_guesses = (1..6).to_a.repeated_permutation(4).to_a
  end

  def remove_guesses(mapped_code, guess)
    @current_pegs = mapped_code.count { |element| guess.include?(element) }
    @possible_guesses = @possible_guesses.select { |array| array.count(guess[1]) >= @current_pegs }
  end

  def random_guesses(turns, mapped_code)
    game_on = true
    while turns >= 0 && game_on
      break if turns.zero?

      @possible_guesses.each do |a|
        turns -= 1
        if a == mapped_code
          puts "the computer guesses your code correctly on turn #{turns}! #{unmap(a, @color_mapping)}"
          game_on = false
        end
        break if turns.zero? || a == mapped_code

        puts "turn:#{turns}, the computer tries to guess! #{unmap(a, @color_mapping)}"
      end
    end
  end

  def guess_the_code(mapped_code)
    turns = 12
    while turns >= 0
      break if turns.zero? || @pegs == 4

      @first_guesses.map do |guess|
        turns -= 1
        puts "turn:#{turns}, the computer tries to guess! #{unmap(guess, @color_mapping)}"
        remove_guesses(mapped_code, guess)
        @pegs += mapped_code.count { |element| guess.include?(element) } # maybe make it a module
        break if @pegs == 4
      end
    end
    random_guesses(turns, mapped_code)
  end

  def start_game
    puts 'make your code for the computer to guess!'
    string = gets.chomp.split
    mapped_code = string.map { |colors| @color_mapping[colors] }
    guess_the_code(mapped_code)
  end
end

class CodeBreaker
  include DisplayBoard
  include Pegs
  include RandomColors
  def initialize
    generate_color
    @code = [generate_color, generate_color, generate_color, generate_color]
  end
  def game_begin
    puts 'type your 4 color guess'
    (1..12).each do |a|
      puts "turn: #{a}"
      string = gets.chomp
      player_guess = string.split
      invalid_color = false
      player_guess.each do |color|
        unless COLORS.include?(color)
          puts "#{color} is not a valid color"
          invalid_color = true
          break
        end
      end
      redo if invalid_color == true
      add_pegs(string, player_guess)
      break if player_guess == @code
    end
    puts "the code was #{@code}"
  end
end
code_breaker = CodeBreaker.new
code_maker = CodeMaker.new
puts '1- code breaker 2- code maker'
user_choice = gets.chomp
if user_choice == '1'
  code_breaker.game_begin
elsif user_choice == '2'
  code_maker.start_game
else
  puts 'wrong command!'
end
