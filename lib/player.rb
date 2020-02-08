class Player
    attr_reader :player_board, :computer_board

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
  end

  def valid_player_placement(ship, coordinates)
    # require "pry"; binding.pry
    @player_board.valid_placement?(ship, coordinates)
  end

  def player_placement(ship, coordinates)
    valid_player_placement(ship, coordinates)
    coordinates.each {|cell| @player_board.cells[cell].place_ship(ship)}
  end

  def take_turn(coordinate)
    #player passes in one coordinate per turn
    @computer_board.cells[coordinate].fire_upon
  end
end
