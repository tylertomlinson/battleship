require_relative 'test_helper'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell_1
  end

  def test_its_attributes
    assert_equal "B4", @cell_1.coordinate
    assert_nil @cell_1.ship
  end

  def test_cells_default_is_empty_and_can_contain_ship
    assert @cell_1.empty?

    @cell_1.place_ship(@cruiser)

    assert_equal @cruiser, @cell_1.ship
    refute @cell_1.empty?
  end

  def test_if_cell_contains_a_ship
    @cell_1.place_ship(@cruiser)

    assert_equal @cruiser, @cell_1.ship
    assert @cell_1.ship?

    cell_3 = Cell.new("B4")

    @cell_2.place_ship(@cruiser)
    assert_equal @cruiser, @cell_1.ship
    refute cell_3.ship?
  end

  def test_cell_can_be_fired_upon
    @cell_1.place_ship(@cruiser)
    refute @cell_1.fired_upon?

    @cell_1.fire_upon

    assert @cell_1.fired_upon?
    assert_equal 2, @cruiser.health
  end

  def test_cell_can_render
    assert_equal ".", @cell_1.render

    @cell_1.fire_upon

    assert_equal "M", @cell_1.render

    @cell_2.place_ship(@cruiser)

    assert_equal ".", @cell_2.render
    assert_equal "S", @cell_2.render(true)

    @cell_2.fire_upon

    assert_equal "H", @cell_2.render
    assert_equal false, @cruiser.sunk?

    @cruiser.hit
    @cruiser.hit

    assert_equal true, @cruiser.sunk?
    assert_equal "X", @cell_2.render
  end
end
