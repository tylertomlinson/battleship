class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    appropriate_length?(ship, coordinates) && ships_cannot_overlap?(coordinates) && consecutive?(coordinates)
  end

  def appropriate_length?(ship, coordinates)
    coordinates.length == ship.length
  end

  def ships_cannot_overlap?(coordinates)
    coordinates.all? { |coordinate| @cells.key?(coordinate) == @cells[coordinate].empty? }
  end

  def consecutive?(coordinates)
    consecutive_letter_coordinates?(coordinates) || consecutive_number_coordinates?(coordinates)
  end

  def letter_coordinates(coordinates)
    coordinates.map(&:chars).map {|coordinate| coordinate[0]}
  end

  def number_coordinates(coordinates)
    coordinates.map(&:chars).map {|coordinate| coordinate[1].to_i}
  end

  def consecutive_letter_coordinates?(coordinates)
    letter_coordinates(coordinates).uniq.size == 1 &&
    number_coordinates(coordinates).each_cons(2).all? { |number1, number2| number2 == (number1 + 1) }
  end

  def consecutive_number_coordinates?(coordinates)
    number_coordinates(coordinates).uniq.size == 1 &&
    letter_coordinates(coordinates).map { |letter| letter.ord }.each_cons(2).all? { |number1, number2| number2 == (number1 + 1) }
  end

  def place(ship, coordinates)
    coordinates.each { |coordinate| @cells[coordinate].place_ship(ship) }
  end
end
# def consecutive?(coordinates)
#   letters_cords = coordinates.map(&:chars).map {|coordinate| coordinate[0]}
#   numbers_cords = coordinates.map(&:chars).map {|coordinate| coordinate[1].to_i}
#   if letters_cords.uniq.size == 1 &&
#   numbers_cords.each_cons(2).all? do |number1, number2|
#     number2 == (number1 + 1)
#   end
#     true
#   elsif numbers_cords.uniq.size == 1 &&
#     letters_cords.map { |letter| letter.ord }.each_cons(2).all? {|number1, number2| number2 == (number1 + 1)}
#     true
#   else
#     false
#   end
# end
