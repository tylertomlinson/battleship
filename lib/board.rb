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
    consecutive_numbers(coordinates)
    ship.health == coordinates.length
  end

  def consecutive_numbers()
  end

  def consecutive_letters?()

  end

  def place(cruiser = Ship.new("Cruiser", 1, "A1"))
    place
  end

  def render(value = false)
    "  1 2 3 4  \n" +
    "A " + @cells["A1"].render(value) + " " + @cells["A2"].render(value) + " " + @cells["A3"].render(value) + " " + @cells["A4"].render(value) + "\n" +
    "B " + @cells["B1"].render(value) + " " + @cells["B2"].render(value) + " " + @cells["B3"].render(value) + " " + @cells["B4"].render(value) + "\n" +
    "C " + @cells["C1"].render(value) + " " + @cells["C2"].render(value) + " " + @cells["C3"].render(value) + " " + @cells["C4"].render(value) + "\n" +
    "D " + @cells["D1"].render(value) + " " + @cells["D2"].render(value) + " " + @cells["D3"].render(value) + " " + @cells["D4"].render(value) + "\n"

    # "  1 2 3 4  \n" +
    # "A" + @cells["A1"].render(value) + @cells["A2"].render(value) + @cells["A3"].render(value) + @cells["A4"].render(value) + "\n" +
    # "B" + @cells["B1"].render(value) + @cells["B2"].render(value) + @cells["B3"].render(value) + @cells["B4"].render(value) + "\n" +
    # "C" + @cells["C1"].render(value) + @cells["C2"].render(value) + @cells["C3"].render(value) + @cells["C4"].render(value) + "\n" +
    # "D" + @cells["D1"].render(value) + @cells["D2"].render(value) + @cells["D3"].render(value) + @cells["D4"].render(value) + "\n"
  end
end
