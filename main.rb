# ASCII representaion of board
# |eeee| |EEEE|
# |eeee| |EEEE|
class Board
  def initialize
    
  end

  def display_board
    puts "|eeee| |EEEE| \n" + 
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
board.display_board