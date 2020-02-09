class Player
    attr_accessor :your_board, :opponent_board

  def initialize
    @your_board = Board.new
    @opponent_board = Board.new
  end

  def valid_player_placement(ship, coordinates)
    @your_board.valid_placement?(ship, coordinates)
  end

  def player_placement(ship, coordinates)
    valid_player_placement(ship, coordinates)
    coordinates.each {|cell| @your_board.cells[cell].place_ship(ship)}
  end

  def take_turn(coordinate)
    @opponent_board.cells[coordinate].fire_upon
  end
end
