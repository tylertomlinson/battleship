require_relative 'test_helper'
require './lib/ship'

class ShipTest < Minitest::Test
  
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_has_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
  end

  def test_ship_can_take_multiple_hits_health_changes_and_sunk_at_0
    assert_equal 3, @cruiser.health

    refute @cruiser.sunk?

    @cruiser.hit

    assert_equal 2, @cruiser.health
    refute @cruiser.sunk?

    @cruiser.hit

    assert_equal 1, @cruiser.health
    refute @cruiser.sunk?

    @cruiser.hit

    assert_equal 0, @cruiser.health
    assert @cruiser.sunk?
  end
end
