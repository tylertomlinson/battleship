class Player
    attr_reader :cruiser, :submarine, :board

  def initialize
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new
  end

  def ships
    @ships = [@cruiser, @submarine]
  end

  def valid_ship_placement(ship, coordinates)
    @board.valid_placement?(ship, coordinates)
  end

  def ship_placement(ship, coordinates)
    valid_ship_placement(ship, coordinates)
    coordinates.each {|cell| @board.cells[cell].place_ship(ship)}
  end

  def take_turn(coordinate, computer_board)
    computer_board.cells[coordinate[0]].fire_upon
  end

  def valid_guess?(coordinate, computer_board)
    computer_board.valid_coordinate?(coordinate[0]) && !computer_board.cells[coordinate[0]].fired_upon?
  end
end
