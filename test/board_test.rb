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

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_board_has_cells
    assert_instance_of Hash, @board.cells
    assert_instance_of Cell, @board.cells["A1"]
  end

  def test_board_can_check_valid_coordinate
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  def test_board_can_check_valid_placement
    skip
    refute @board.valid_placement?(cruiser, ["A1", "A2"])
    refute @board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert @board.valid_placement?(submarine, ["A1", "A2"])
    assert @board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_board_can_check_if_valid_placement_is_consecutive
    skip
    refute @board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute @board.valid_placement?(submarine, ["A1", "C1"])
    refute @board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_board_can_check_valid_placement_is_not_diagonal
    skip
    refute @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(submarine, ["C2", "D3"])
  end
end