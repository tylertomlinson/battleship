require_relative 'test_helper'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_its_attributes
    assert_equal "B4", @cell.coordinate
    assert_nil @cell.ship
  end

  def test_cells_default_is_empty_and_can_contain_ship
    assert @cell.empty?

    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    refute @cell.empty?
  end

  def test_cell_can_be_fired_upon
    @cell.place_ship(@cruiser)
    refute @cell.fired_upon?

    @cell.fire_upon
    assert @cell.fired_upon?
    assert_equal 2, @cruiser.health
  end
end
