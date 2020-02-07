class Cell
  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship != nil
      @ship.hit
    end
      @fired_upon = true
  end

  def render(show_ship = false)
    return 'M' if @fired_upon == true && empty?
    return 'X' if @fired_upon == true && @ship.health < 1
    return 'H' if @fired_upon == true && !empty?
    return 'S' if show_ship == true && !empty?
    return '.'
  end
end
