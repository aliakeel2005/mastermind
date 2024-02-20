# ASCII representaion of board
# make computer generate code
# make random number generator from 1 to 6
# make object with numbers corrosponding to their colors
# OBJ = {1: red, 2: blue, 3: yellow}
# 

module RandomColors
  def generate_color
    colors = {1 => 'red', 2 => 'blue', 3 => 'yellow', 4 => 'green', 5 => 'brown', 6 => 'purple'}
    colors[rand(1..6)]
  end
end

class Board
  include RandomColors
  attr_accessor :code
  def initialize
    @code = {1 => generate_color, 2 => generate_color, 3 => generate_color, 4 => generate_color}
  end

  def display_board
    puts "|#{@code[1]}eee| |EEEE| \n" + 
         "|eeee| |EEEE| \n" +
         "|eeee| |EEEE| \n" +
         "|eeee| |EEEE| \n" +
         "|eeee| |EEEE| \n" +
         "|eeee| |EEEE| \n" +
         "|eeee| |EEEE| \n" +
         "|eeee| |EEEE| \n" +
         "|eeee| |EEEE| \n" +
         "|eeee| |EEEE| \n" +
         "|eeee| |EEEE| \n" +
         "|eeee| |EEEE| \n" 
  end
end

board = Board.new 
  # p color = {1 => board.generate_color, 2 => board.generate_color, 3 => board.generate_color, 4 => board.generate_color}
board.display_board