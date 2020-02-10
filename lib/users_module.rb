require 'pastel'
require 'tty-font'

module UsersModule

  def your_board
    @user_board = Board.new
  end

  def computer_board
    @computer_board = Board.new
  end
  def valid_ship_placement(ship, coordinates)
    @user_board.valid_placement?(ship, coordinates)
  end

  def ship_placement(ship, coordinates)
    valid_ship_placement(ship, coordinates)
    coordinates.each {|cell| @user_board.cells[cell].place_ship(ship)}
  end

  def take_turn(coordinate)
    @computer_board.cells[coordinate[0]].fire_upon
  end
end
