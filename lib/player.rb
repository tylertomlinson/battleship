class Player
    attr_accessor :board

  def initialize
    @board = Board.new
  end

  def valid_ship_placement(ship, coordinates)
    @board.valid_placement?(ship, coordinates)
  end

  def ship_placement(ship, coordinates)
    valid_ship_placement(ship, coordinates)
    coordinates.each {|cell| @board.cells[cell].place_ship(ship)}
  end

  def take_turn(coordinate)
    require "pry"; binding.pry
    @board.cells[coordinate[0]].fire_upon
  end

  def valid_guess?(coordinate)
      @board.valid_coordinate?(coordinate) && @board.cells[coordinate].fired_upon?
  end
end
