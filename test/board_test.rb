require_relative 'test_helper'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_board_can_check_valid_coordinate
    assert @board.valid_coordinate("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  def test_board_can_check_valid_placement
  refute @board.valid_placement?(cruiser, ["A1", "A2"])
  refute @board.valid_placement?(submarine, ["A2", "A3", "A4"])
  assert @board.valid_placement?(submarine, ["A1", "A2"])
  assert @board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end
end
