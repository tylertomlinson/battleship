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
<<<<<<< HEAD
    skip
=======
>>>>>>> 56d4e67ab3af8c17e00d29f9e97e19890d2af8bb
    assert_instance_of Hash, @board.cells
    assert_instance_of Cell, @board.cells["A1"]
  end

<<<<<<< HEAD

  def test_board_can_check_valid_coordinate
=======
  def test_board_can_check_valid_coordinates
>>>>>>> 56d4e67ab3af8c17e00d29f9e97e19890d2af8bb
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  def test_ship_length_is_the_same_as_input_coordinates
    assert_equal true, @board.appropriate_length?(@submarine, ["A1", "A2"])
    assert_equal false, @board.appropriate_length?(@cruiser, ["B1", "B2", "C3", "D4"])
  end

  def test_coordinates_are_consecutive
    assert @board.consecutive?(["A1", "B1"])
    refute @board.consecutive?(["A1", "A2", "A4"])
  end

  def test_board_can_check_valid_placement
<<<<<<< HEAD
    # refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    # refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    # assert @board.valid_placement?(@submarine, ["A1", "A2"])
    # assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_consecutive_numbers_works
    @board.consecutive_numbers(["A1", "A2", "A3"])
    assert_equal [1,2,3], @board.consecutive_numbers(["A1", "A2", "A3"])
    @board.consecutive_numbers(["A1", "A2", "A4"])
    assert_equal [1,2,4], @board.consecutive_numbers(["A1", "A2", "A4"])

  end

  def test_board_can_check_if_valid_placement_is_consecutive
    skip
=======
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_board_can_check_if_valid_placement_is_consecutive
>>>>>>> 56d4e67ab3af8c17e00d29f9e97e19890d2af8bb
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    refute @board.valid_placement?(@submarine, ["A1", "C1"])
    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_board_can_check_valid_placement_is_not_diagonal
<<<<<<< HEAD
    skip
=======
>>>>>>> 56d4e67ab3af8c17e00d29f9e97e19890d2af8bb
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

<<<<<<< HEAD
  def test_board_can_be_rendered
    skip
    # assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", @board.render
    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", @board.render(true)
=======
  def test_ship_is_able_to_be_placed_on_board_and_can_occupy_multiple_cells
    @board.place(@cruiser, ["A1", "A2", "A3"])

    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    assert_instance_of Ship, cell_1.ship
    assert_instance_of Ship, cell_2.ship
    assert_instance_of Ship, cell_3.ship
>>>>>>> 56d4e67ab3af8c17e00d29f9e97e19890d2af8bb
  end
end
